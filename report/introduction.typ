#import "@preview/physica:0.9.4": ket

= Introduction
Technology has been a steadfast pillar supporting humanity's progress, developing recursively, building upon generations of inventions and discoveries to solve ever more challenging problems. Well into the Silicon Age, tasks ranging from mundane automation to artificial intelligence like ChatGPT, DeepSeek, Grok have become possible. Yet, for all the progress in the field of computing to date, there remain problems that are intractable for classical computing systems, such as breaking public-key cryptography schemes #cite(<shor_algo>).

This limit stems from the classical bit being constrained to either 0 or 1. Considering a superset of decimal values bounded by 0 and 1 (inclusive), the classical system falls short in terms of its information encoding capacity. Exploiting this superset would tremendously increase the system's computational power, making it feasible to solve a whole new class of problems.

== Age of Quantum Computing
To access this superset, a new kind of computer is required. It is to be built with quantum bits or qubits #cite(<qubits>) which, unlike classical bits, can be described by linear combinations of two orthogonal vectors $ket(0) = vec(1, 0)$ and $ket(1) = vec(0, 1)$:

#align(center)[$ket(psi) = alpha ket(0) + beta ket(1)$]

where $alpha$ and $beta$ are the complex probability amplitudes subject to the $abs(alpha)^2 + abs(beta)^2 = 1$ constraint #cite(<quantum_textbook>). This is a consequence of quantum mechanical superposition, in which the system can exist in multiple states simultaneously rather than being confined to a single definite state.

Architectures available right now. This thesis focuses on electrostatically-defined quantum dot devices. 

Google Willow, IBM, Rigetti, IONQ.


== Electrostatically-defined quantum dot devices
=== Architecture
=== Fabrication
=== Gate electrode layout

== Machine Learning
=== Multi-Agent Reinforcement Learning (MARL)

lorem ipsum lorem ipsum

$ | f(x) - f(c) | < epsilon $ <eq-range-small>
