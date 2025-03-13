#import "@preview/subpar:0.2.1"

= Literature Review
== Quantum Dot Devices
A QD is a potential well confined in three dimensions. In the context of QD devices, employing the 2 dimensional electron gas (2DEG) model allows for more convenient discussions on the QD.

 With reference to @fig_1a, the single QD is connected to source and drain contacts via tunneling barriers. Each barrier can be modelled as a parallel connection between a tunneling resistor and a tunneling capacitor: $C_S$ with $R_S$ for the source and $C_D$ with $R_D$ for the drain. The QD is also connected to a gate electrode via capacitance $C_G$, and the electrode provides an overall control mechanism for the tunneling of electrons into the QD via gate potential $V_G$ @gate_controlled_qd. Practical systems typically rely on more gate electrodes to effectively control qubits. The presence of more than one gate electrode on the QD device introduces the challenge of gate layouts.

#subpar.grid(
  figure(image("images/single_quantum_dot.svg", width: 61%), caption: [
    Single QD
  ]), <fig_1a>,
  figure(image("images/double_quantum_dot.svg", width: 84%), caption: [
    Double QD
  ]), <fig_1b>,
  rows: (10em, 10em),
  row-gutter: 3em,
  caption: [Networks of tunneling resistors and capacitors used in QD architectures.],
  label: <fig_1>,
)


== Gate Electrodes
=== Architecture
=== Fabrication

== Machine Learning
=== Multi-Agent Reinforcement Learning (MARL)
State-action space
=== Deep Q Learning
=== Proximal Policy Optimisation (PPO)
=== Group Relative Policy Optimisation (GRPO)