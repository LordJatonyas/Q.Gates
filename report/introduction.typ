#import "@preview/physica:0.9.4": ket

= Introduction

The introduction of the qubit has made possible solutions to intractable problems in classical computation @qubits. Unlike a classical bit, a qubit $ket(psi)$ can be described by a linear combination of two orthogonal vectors $ket(0) = vec(1, 0)$ and $ket(1) = vec(0, 1)$:

#align(center)[$ket(psi) = alpha ket(0) + beta ket(1)$]

where $alpha$ and $beta$ are the  probability amplitudes subject to the $abs(alpha)^2 + abs(beta)^2 = 1$ constraint @quantum_textbook. This is a consequence of quantum mechanical superposition, in which systems can exist in multiple states simultaneously rather than being confined to single definite states. 

The main advantage of using qubits is the immense computational power they provide. To put this into perspective, just $N$ qubits can hold as much information as $2^N$ classical binary bits. This improvement has the potential to massively benefit humanity across countless domains, and of the many methods that have been proposed to realise this power, the quantum dot (QD) has emerged as a promising candidate due to its compatibility with semiconductor manufacturing processes and potential for scalability @ekimov-semiconductor.

On a high level, QDs are nanoscale structures that function as "three-dimensional boxes" used to capture electrons which serve as the qubits @quantum_textbook. Specifically, this thesis focuses on electrostatically-defined QD devices, where confinement is done via external electrostatic potentials applied through gate electrodes. Gate properties including electrostatic potential, positioning, and geometry of multiple gate electrodes are tuned to facilitate QD formation and qubit control. Considering the limited space for components on QD devices, these parameters define the challenge of designing optimal gate electrode layouts.

The design and tuning of gate electrodes has historically been based on iterative, trial-and-error approaches; expert researchers employ their intuition and experience to manually tune devices, adjusting multiple gate electrode voltages to achieve desired electronic configurations. This exploratory method has been invaluable in demonstrating the viability of QD qubits and learning more about their physics, revealing critical relationships between design parameters and qubit performance.

However, the process is tedious, expensive, and often leads to complicated gate geometries that increase the manufacturing complexity. Furthermore, current designs do not guarantee optimal layout design.

 Overall, this paradigm hinders the advancement of QD technology toward practical quantum computing applications. 

limiting consistency, reproducibility, and scalability.

With the accelerated progress of artificial intelligence (AI) in recent years, there is a growing opportunity of letting AI conduct the aforementioned exploration.

However, this paradigm also hinders the advancement of QD technology toward practical quantum computing applications. Crucially, it limits consistency, reproducibility, and scalability, features that will become increasingly important as quantum computing matures. Furthermore, current designs do not guarantee optimal electrode usage. 


Working towards the goal of standardisation, this thesis investigates the use of #emph[*physics-based reinforcement learning to optimally design simple geometry gate electrode layouts*].
