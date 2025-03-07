#import "@preview/physica:0.9.4": ket

= Introduction

== Age of Quantum Computing
Classical computing is fundamentally limited in computational power due to the binary constraint on the bit (0 or 1). Compared to a superset of values between 0 and 1 (inclusive), current computing falls utterly short in its information encoding capacity. As a result, for all the progress made in the field of computing to date, there remain problems that are intractable for these systems, such as the task of breaking public-key cryptography schemes #cite(<shor_algo>).

The creation of quantum computers promises solutions to these problems by changing the information unit from the bit to the quantum bit or qubit #cite(<qubits>). Unlike a classical bit, a qubit $ket(psi)$ can be described by a linear combination of two orthogonal vectors $ket(0) = vec(1, 0)$ and $ket(1) = vec(0, 1)$:

#align(center)[$ket(psi) = alpha ket(0) + beta ket(1)$]

where $alpha$ and $beta$ are the  probability amplitudes subject to the $abs(alpha)^2 + abs(beta)^2 = 1$ constraint #cite(<quantum_textbook>). This is a consequence of quantum mechanical superposition, in which the system can exist in multiple states simultaneously rather than being confined to a single definite state. This unlocks an extraordinary increase in computational power. To put this into perspective, $N$ qubits can hold as much information as $2^N$ classical bits.

Many implementations have been proposed to realise this power, one of them being the quantum dot. Quantum dots were first introduced as a way to ... Ekimov 1981

This thesis focuses on electrostatically-defined quantum dot devices. 

Technology develops recursively, building upon generations of discoveries and inventions to refine solutions or solve ever challenging problems. As the benefits of quantum computing become increasingly well-understood, more effort has been poured into creating better quantum computers. Google Willow, IBM, Rigetti, IONQ.


== Electrostatically-defined quantum dot devices
=== Architecture
=== Fabrication
=== Gate electrode layout

== Machine Learning
=== Multi-Agent Reinforcement Learning (MARL)
=== Deep Q Learning
=== Proximal Policy Optimisation (PPO)
=== Group Relative Policy Optimisation (GRPO)


lorem ipsum lorem ipsum

$ | f(x) - f(c) | < epsilon $ <eq-range-small>
