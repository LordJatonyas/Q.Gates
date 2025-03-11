#import "@preview/physica:0.9.4": ket

= Introduction

The arrival of quantum computers promises solutions to classically intractable problems by changing the fundamental information unit from the binary bit to the quantum bit or qubit @qubits. Unlike a classical bit, a qubit $ket(psi)$ can be described by a linear combination of two orthogonal vectors $ket(0) = vec(1, 0)$ and $ket(1) = vec(0, 1)$:

#align(center)[$ket(psi) = alpha ket(0) + beta ket(1)$]

where $alpha$ and $beta$ are the  probability amplitudes subject to the $abs(alpha)^2 + abs(beta)^2 = 1$ constraint @quantum_textbook. This is a consequence of quantum mechanical superposition, in which the system can exist in multiple states simultaneously rather than being confined to a single definite state. This unlocks an extraordinary increase in computational power. To put this into perspective, $N$ qubits can hold as much information as $2^N$ classical bits.

Many methods have been proposed to realise this power, such as superconducting, trapped-ion, topological, and quantum dot (QD) qubits. Specifically, this thesis focuses on electrostatically-defined QD devices. On a high level, the QD functions like a "three-dimensional box" using electrostatic potentials to confine electrons which serve as the qubits @quantum_textbook. To receive the electrons, it is connected to a source and a drain. It is also capacitively coupled with gate electrodes, offering an overall control mechanism for the tunneling of electrons into the QD @gate_controlled_qd.

#figure(
    grid(columns: 1, rows: 2, row-gutter: 10mm, column-gutter: 1mm,
        image("images/single_quantum_dot.svg", width: 75%),
        image("images/double_quantum_dot.svg", width: 90%),
    ),
    caption: [Double QD circuit diagram],
)

In practice, suitable gate layouts are designed experimentally to achieve desired QDs. This has led to wide differences in geometry, positioning, number of gates, and gate potentials among existing quantum dot devices. The diversity has been helpful in demonstrating the design possibilities, but limits reproducibility and scalability, aspects that will be important as quantum computing matures. Working towards the goal of standardisation, this thesis investigates the use of #emph[*physics-based reinforcement learning to optimally design simple geometry gate electrode layouts*].