import zlib
import struct
import numpy as np
import random
import os

def makeTransparentPNG(data, height = None, width = None):
    def I1(value):
        return struct.pack("!B", value & (2**8-1))
    def I4(value):
        return struct.pack("!I", value & (2**32-1))
    
    if height is None:
        height = len(data)
    if width is None:
        width = 0
        for row in data:
            if width < len(row):
                width = len(row)
    
    # PNG header
    png = b"\x89" + "PNG\r\n\x1A\n".encode('ascii')
    
    # IHDR chunk
    colortype = 6  # RGBA
    bitdepth = 8
    compression = 0
    filtertype = 0
    interlaced = 0
    IHDR = I4(width) + I4(height) + I1(bitdepth)
    IHDR += I1(colortype) + I1(compression)
    IHDR += I1(filtertype) + I1(interlaced)
    block = "IHDR".encode('ascii') + IHDR
    png += I4(len(IHDR)) + block + I4(zlib.crc32(block))
    
    # IDAT chunk
    raw = b""
    for y in range(height):
        raw += b"\0"  # no filter for this scanline
        for x in range(width):
            if y < len(data) and x < len(data[y]):
                value = data[y][x]
                # RGBA format: R=G=B=0 for gate (black), A=255 for gate, 0 for background
                if value == 0:  # Gate electrode
                    raw += b"\0\0\0\xFF"  # Black with full opacity
                else:
                    raw += b"\0\0\0\0"  # Transparent
            else:
                raw += b"\0\0\0\0"  # Transparent
    
    compressor = zlib.compressobj()
    compressed = compressor.compress(raw)
    compressed += compressor.flush()
    block = "IDAT".encode('ascii') + compressed
    png += I4(len(compressed)) + block + I4(zlib.crc32(block))
    
    # IEND chunk
    block = "IEND".encode('ascii')
    png += I4(0) + block + I4(zlib.crc32(block))
    
    return png

def generate_gate_electrode(width=934, height=625, gate_type='plunger', gate_number=0):
    """
    Generate a SEM image with a gate electrode of specified type.
    gate_type can be: 'plunger', 'barrier_left', 'barrier_right', 'reservoir_left', 'reservoir_right'
    """
    # Initialize image with white background (255)
    image = np.full((height, width), 255, dtype=np.uint8)
    
    # Pre-calculate common values
    center_x = width // 2
    reservoir_y_start = (height - 65) // 2 - 50  # Using max reservoir height
    
    # Gate dimensions
    if gate_type.startswith('reservoir'):
        # Reservoir gates: horizontal, wider than tall
        gate_height = random.randint(60, 65)  # Height is now the shorter dimension
        
        if gate_type == 'reservoir_left':
            # Left reservoir extends from left border to 20px before center
            image[reservoir_y_start:reservoir_y_start + gate_height, :center_x - 120] = 0
        else:  # reservoir_right
            # Right reservoir extends from right border to 20px after center
            image[reservoir_y_start:reservoir_y_start + gate_height, center_x - 100:] = 0
            
    elif gate_type == 'plunger':
        # Plunger gate: medium width, medium length
        gate_width = random.randint(70, 85)
        gate_length = random.randint(250, 270)
        # Center the plunger horizontally
        start_x = (width - gate_width) // 2
        # Position from bottom
        start_y = height - gate_length
        # Check if plunger would overlap with reservoirs
        if start_y < reservoir_y_start + 65 + 15:  # If would overlap
            gate_length = reservoir_y_start - (height - gate_length) - 15  # Adjust length to maintain gap
            start_y = height - gate_length
        image[start_y:height, start_x:start_x + gate_width] = 0
        
    elif gate_type.startswith('barrier'):
        # Barrier gates: narrow, longer than plunger
        gate_width = random.randint(55, 65)
        gate_length = random.randint(280, 295)  # Longer than plunger
        
        # Get plunger dimensions for positioning
        plunger_width = 83  # Average plunger width
        
        # Calculate center position of plunger
        plunger_center = width // 2
        
        # Position barrier gates with 15px gap from plunger
        if gate_type == 'barrier_left':
            # Position left barrier gate
            start_x = plunger_center - (plunger_width // 2) - gate_width - 15
            # Ensure it doesn't go off the left edge
            if start_x < 0:
                # Adjust plunger position to accommodate barrier
                plunger_center = (gate_width + 15 + plunger_width // 2)
                start_x = 0
        else:  # barrier_right
            # Position right barrier gate
            start_x = plunger_center + (plunger_width // 2) + 15
            # Ensure it doesn't go off the right edge
            if start_x + gate_width > width:
                # Adjust plunger position to accommodate barrier
                plunger_center = width - (gate_width + 15 + plunger_width // 2)
                start_x = width - gate_width
        
        # Position from bottom
        start_y = height - gate_length
        
        # Check if barrier would overlap with reservoirs
        if start_y < reservoir_y_start + 65 + 15:  # If would overlap
            gate_length = reservoir_y_start - (height - gate_length) - 15  # Adjust length to maintain gap
            start_y = height - gate_length
            
        # Always draw the barrier gate
        image[start_y:height, start_x:start_x + gate_width] = 0
        
        # If we adjusted the plunger position, update the plunger gate
        if gate_type == 'barrier_left' and start_x == 0:
            plunger_start_x = plunger_center - (plunger_width // 2)
            image[height - gate_length:height, plunger_start_x:plunger_start_x + plunger_width] = 0
        elif gate_type == 'barrier_right' and start_x == width - gate_width:
            plunger_start_x = plunger_center - (plunger_width // 2)
            image[height - gate_length:height, plunger_start_x:plunger_start_x + plunger_width] = 0
    
    return image.tolist()

def generate_gate_positions(max_images=10):
    """
    Generate SEM images for different gate electrode configurations
    """
    # Create output directory if it doesn't exist
    os.makedirs('../gate_images', exist_ok=True)
    
    # Generate images with different combinations of gates
    image_count = 0
    
    # Generate images with all gates
    sem_image = np.full((625, 934), 255, dtype=np.uint8)  # Initialize with white background
    
    # Add reservoir gates
    for side in ['left', 'right']:
        reservoir = generate_gate_electrode(gate_type=f'reservoir_{side}')
        sem_image = np.minimum(sem_image, np.array(reservoir))
    
    # Add plunger gate
    plunger = generate_gate_electrode(gate_type='plunger')
    sem_image = np.minimum(sem_image, np.array(plunger))
    
    # Add barrier gates
    for side in ['left', 'right']:
        barrier = generate_gate_electrode(gate_type=f'barrier_{side}')
        sem_image = np.minimum(sem_image, np.array(barrier))
    
    # Save the complete configuration
    output_path = f'../gate_images/complete_configuration.png'
    with open(output_path, "wb") as f:
        f.write(makeTransparentPNG(sem_image.tolist()))
    print(f"Generated {output_path}")
    
    # Generate individual gate images
    gate_types = ['plunger', 'barrier_left', 'barrier_right', 'reservoir_left', 'reservoir_right']
    for gate_idx, gate_type in enumerate(gate_types):
        if image_count >= max_images - 1:  # -1 because we already generated the complete configuration
            break
            
        # Generate the image
        sem_image = generate_gate_electrode(gate_type=gate_type)
        
        # Save the image
        output_path = f'../gate_images/SEM_gate_{gate_idx}.png'
        with open(output_path, "wb") as f:
            f.write(makeTransparentPNG(sem_image))
        print(f"Generated {output_path}")
        image_count += 1

def _example():
    generate_gate_positions(max_images=10)

if __name__ == "__main__":
    _example()
