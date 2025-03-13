#import "@preview/physica:0.9.4": ket

= Introduction

The arrival of quantum computers makes solutions to classically intractable problems possible by changing the fundamental information unit from the binary bit to the quantum bit or qubit @qubits. Unlike a classical bit, a qubit $ket(psi)$ can be described by a linear combination of two orthogonal vectors $ket(0) = vec(1, 0)$ and $ket(1) = vec(0, 1)$:

#align(center)[$ket(psi) = alpha ket(0) + beta ket(1)$]

where $alpha$ and $beta$ are the  probability amplitudes subject to the $abs(alpha)^2 + abs(beta)^2 = 1$ constraint @quantum_textbook. This is a consequence of quantum mechanical superposition, in which the system can exist in multiple states simultaneously rather than being confined to a single definite state. This unlocks an extraordinary increase in computational power. To put this into perspective, $N$ qubits can hold as much information as $2^N$ classical bits. Of the many methods have been proposed to realise this power, the quantum dot (QD) has emerged as a promising candidate due to its compatibility with semiconductor manufacturing processes and potential for scalability.

On a high level, QD are nanoscale structures that function as "three-dimensional boxes" used to capture electrons which serve as the qubits @quantum_textbook. Specifically, this thesis focuses on electrostatically-defined QD devices, where confinement is done via external electrostatic potentials applied through gate electrodes. Gate potential, positioning, and geometry greatly impact QD formation and qubit control. Additionally, practical systems typically rely on more than one gate electrode to effectively control qubits. Considering the physical constraints on QD devices, these parameters define the challenge of repeatably designing optimal gate electrode layouts.

The design and tuning of gate electrodes has historically been based on iterative, trial-and-error approaches. Expert researchers employ their intuition and experience to manually tune devices, adjusting multiple gate electrode voltages to achieve desired electronic configurations. This exploratory method has been invaluable in demonstrating the viability of QD qubits and learning more about their physics, revealing critical relationships between design parameters and qubit performance.

However, this paradigm also hinders the advancement of QD technology toward practical quantum computing applications. Crucially, it limits consistency, reproducibility, and scalability, features that will become increasingly paramount as quantum computing matures. Working towards the goal of standardisation, this thesis investigates the use of #emph[*physics-based reinforcement learning to optimally design simple geometry gate electrode layouts*].
