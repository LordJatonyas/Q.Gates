#import "@preview/subpar:0.2.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import fletcher.shapes: house, hexagon

#let blob(pos, label, tint: white, ..args) = node(
	pos, align(center, label),
	width: 28mm,
	fill: tint.lighten(60%),
	stroke: 1pt + tint.darken(20%),
	corner-radius: 0pt,
	..args,
)

= Literature Review
== Quantum Dot Devices
Alluded to in the previous section, a QD is a static potential well confined in 3D that traps electrons for qubit measurement. In the context of QD devices, employing the 2 dimensional electron gas (2DEG) model allows for more convenient discussions.

 With reference to @single_qd_network, the single QD is connected to source and drain contacts via tunneling barriers. Each barrier can be modelled as a parallel connection between a tunneling capacitor and a tunneling resistor: $C_S$ with $R_S$ for the source and $C_D$ with $R_D$ for the drain. The QD is also connected to a gate electrode via capacitance $C_G$, and the electrode provides an overall control mechanism for the tunneling of electrons into the QD via gate potential $V_G$ @gate_controlled_qd.

#subpar.grid(
  figure(image("images/single_quantum_dot.svg", width: 61%), caption: [
    Single QD
  ]), <single_qd_network>,
  figure(image("images/double_quantum_dot.svg", width: 84%), caption: [
    Double QD
  ]), <double_qd_network>,
  rows: (10em, 10em),
  row-gutter: 3em,
  caption: [Networks of tunneling resistors and capacitors in QD architectures.],
  label: <qd_network>,
)

This model can be extended to architectures that capture more qubits, such as the double quantum dot in @double_qd_network. In this scenario, the coupling between the QDs can be characterised by interdot capacitance $C_M$ and resistance $R_M$. Gate electrode connections are similar to the previous case, each QD being connected via a capacitance. In practical systems, more gate electrodes are utilised to effectively control qubits. The presence of more than one gate electrode on a typical QD device with size constraints introduces the challenge of gate layouts.

== Gate Electrodes
=== Architecture
=== Fabrication

== Multi-Agent Reinforcement Learning
Reinforcement learning is a paradigm in machine learning where an agent learns optimal behaviour through trial-and-error interactions with an environment @sutton_barto. Unlike supervised learning, it relies on reward signals, not labelled datasets, to guide learning. Unlike unsupervised learning, it has explicit feedback in the form of rewards, penalties, and predefined goals. This category of methods is most suitable for the task of designing optimal gate electrode layouts due to the need for physics-based feedback, but lack of sufficient "correct" and optimal layouts.

#figure(
  // diagram(
  //   spacing: 8pt,
  //   cell-size: (20mm, 20mm),
  //   edge-stroke: 1pt,
  //   edge-corner-radius: 0pt,
  //   mark-scale: 130%,

  //   blob((0.15,0.5), text(size: 13pt, [*Agent*]), width: 80pt, height: 40pt, tint: rgb("#fdd661")),
  //   edge((0.4,0.3), "rr,dd,ll", "-}>", [action], label-pos: 0.48, label-side: center),
  //   blob((0.15,2), text(size: 13pt, [*Environment*]), width: 200pt, height: 60pt, tint: gray),
  //   edge((0,2.3), "ll,uu,rr", "-}>", [state], label-pos: 0.52, label-side: center),
  //   edge((0,1.7), "l,u,r", "-}>", [reward], label-pos: 0.5, label-side: center),
  // ),
  image("images/single-agent_rl.png", height: 130pt),
  caption: [Schematic of single-agent reinforcement learning.],
) <single_agent_rl>

Placed in an environment setting, a single agent adapts its method of getting rewards through a learning loop shown in @single_agent_rl @marl. The agent first takes an action in the environment, altering the state, a representation of the current situation. A reward signal is also produced based on the action, and together with an observation of the state, they inform the agent of the next best action to take. Over multiple iterations, the agent begins to learn a strategy that maps states to actions, otherwise known as policy. The agent's objective in this entire process is to maximise the cumulative discounted reward, or return:

$ G_t = sum_(k=0)^infinity gamma^k r_(t+k) $ <return-eqn>
where $gamma in [0, 1]$ is a discount factor that determines how much importance is placed on future rewards (e.g. $gamma = 0 arrow.r.double$ only immediate rewards considered).

Further to the design task, the idea that an individual gate electrode acts as an agent in the QD forming task makes reinforcement learning particularly enticing. A problem that arises is that the actual design task involves more than one gate electrode, otherwise practical QDs cannot be formed; it is a multi-agent setting in which the model of reinforcement learning in @single_agent_rl cannot be directly applied. Rather, the multi-agent reinforcement learning (MARL) model in @multi_agent_rl should be used to learn optimal policies for a set of agents in such settings @mal.

#figure(
  image("images/marl.png", height: 230pt),
  caption: [Schematic of multi-agent reinforcement learning.],
) <multi_agent_rl>

@multi_agent_rl highlights the differences of this model, notably the joint action that is a combination of the individual actions by different agents, and the separate observation-reward pairs that inform each agent of its next best action @marl. In the context of the layout design problem, applying MARL effectively decomposes the problem of learning an overall layout into smaller problems of each gate electrode learning its own optimal strategy for QD formation. However, choosing MARL only provides a general direction to a potential solution; more details are required to define an exact approach.

Game models under MARL can be organised hierarchically based on the number of agents, the number of states present, and the level of observability for these states by every agent as demonstrated in @game_models @marl. The layout design problem can be described as having $n$ agents (gate electrodes) and $m$ states (potential map), each state fully observable by all agents, thereby fitting the #emph[stochastic game] model's description. As such, MARL algorithms implemented in this thesis would rely on the stochastic game model as foundation.

#figure(
  image("images/marl_hierarchy.png", height: 230pt),
  caption: [Hierarchy of game models.],
) <game_models>



=== 
=== Multi-Agent Deep Deterministic Policy Gradient 
=== Multi-Agent Proximal Policy Optimisation