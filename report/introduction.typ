#import "@preview/physica:0.9.4": ket

= Introduction

The introduction of the qubit made possible solutions to intractable problems in classical computation @qubits. Unlike a classical binary bit, a qubit $ket(psi)$ can be described by a linear combination of two orthogonal vectors $ket(0) = vec(1, 0)$ and $ket(1) = vec(0, 1)$:

#align(center)[$ket(psi) = alpha ket(0) + beta ket(1)$]

where $alpha$ and $beta$ are the  probability amplitudes subject to the $abs(alpha)^2 + abs(beta)^2 = 1$ constraint @quantum_textbook. This is a result of quantum mechanical superposition, in which systems can exist in multiple states simultaneously. The key advantage of this is the immense computational power it provides: just $N$ qubits can hold as much information as $2^N$ classical binary bits.

This exponential improvement has the potential to massively benefit humanity across countless domains including climate modelling, cybersecurity, drug discovery, and materials simulations. Fittingly, enormous effort has been poured by academia and industry to create application-ready quantum computers with high numbers of qubits and fault tolerance. Of the many methods that have been proposed to realise this power, the quantum dot (QD) has emerged as a promising candidate due to its compatibility with semiconductor manufacturing processes and potential for scalability @ekimov-semiconductor.

On a high level, QDs are nanoscale structures that function as "three-dimensional boxes" used to confine electrons @quantum_textbook. When confined in the QD, the electron receives a quantised energy spectrum, and its spin characterises the qubit that is measured @spin-qubits. Specifically, this thesis focuses on electrostatically-defined QD devices, where QD formation is achieved by external electrostatic potentials applied through gate electrodes. These gate electrodes can be tuned in terms of their properties (including electrostatic potential, 2D positioning, 2D and 3D geometries) to facilitate QD formation and qubit control. These parameters, in addition to the number of gate electrodes for a given QD, define the challenge of designing optimal gate electrode layouts for QD devices.

The design and tuning of gate electrodes has historically been based on iterative, trial-and-error approaches; expert researchers employ their intuition and experience to manually tune devices, adjusting multiple gate electrode voltages to achieve desired electronic configurations. This exploratory method has been invaluable in demonstrating the viability of QD qubits and learning more about their physics, revealing critical relationships between design parameters and qubit performance.

However, the process is tedious, expensive, and often leads to complicated gate geometries that increase the manufacturing complexity. Furthermore, current designs do not guarantee optimal layout design. Overall, this paradigm hinders the advancement of QD technology toward practical quantum computing applications. In ignoring the manufacturing problem, it unwittingly limits optimality and scalability, features that will become increasingly important as quantum computing matures.

Machine learning (ML) serves as a possible solution to the aforementioned exploration problem. Methods in reinforcement learning (RL) 

Working towards the goal of standardisation, this thesis investigates the use of #emph[*physics-based reinforcement learning to optimally design simple geometry gate electrode layouts*].
