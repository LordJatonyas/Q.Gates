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
Reinforcement learning is a paradigm in machine learning where an agent learns optimal behaviour through trial-and-error interactions with an environment @sutton_barto. It relies on reward signals and not labelled datasets for learning (unlike supervised learning), and has explicit feedback in the form of rewards, penalties, and predefined goals (unlike unsupervised learning). This paradigm is most suitable for the task of designing optimal gate electrode layouts due to the need for physics-based feedback, but lack of sufficient "correct" and optimal layouts.

By treating each gate electrode as an agent, the problem can be modelled using multi-agent reinforcement learning (MARL), in which optimal strategies are learnt for a set of agents in a multi-agent setting @mal. @multi_agent_rl highlights the main differences of this model from single-agent reinforcement learning, notably the joint action which is a combination of the individual actions by different agents, and the separate observation-reward pairs that inform each agent of its next best action @marl. Over multiple iterations or #emph[episodes], agents begin to learn strategies that map states to actions, otherwise known as #emph[policies]. Each agent's objective in this entire process is to maximise the cumulative discounted reward, or #emph[return]:

$ G_t = sum_(k=0)^infinity gamma^k r_(t+k) $ <return-eqn>
where $gamma in [0, 1]$ is a discount factor that determines how much importance is placed on future rewards (e.g. $gamma = 0 arrow.r.double$ only immediate rewards considered).

#figure(
  image("images/marl.png", height: 190pt),
  caption: [Schematic of multi-agent reinforcement learning.],
) <multi_agent_rl>

To fully specify solutions to the problem, it is useful to consider the type of #emph[game model] that would most accurately describe the layout design problem. In reinforcement learning, game models can be organised hierarchically based on the number of agents, the number of states present, and the level of observability for these states by every agent as demonstrated in @game_models @marl. The layout design problem can be described as having $n$ agents (gate electrodes) and $m$ states (potential maps), each state fully observable by all agents. This fits the #emph[stochastic game] model's description, therefore, MARL algorithms implemented in this thesis would be built on this game model.

#figure(
  image("images/marl_hierarchy.png", height: 190pt),
  caption: [Hierarchy of game models.],
) <game_models>

=== Stochastic Games
The stochastic game model was introduced by Shapley to address the need for a general framework that could model dynamic interactions among multiple decision-makers where the state changes in response to the players’s choices @stochastic-games. To train agents to learn optimal policies, the stochastic game should have a fixed number of training episodes. In this finite-horizon game setting, a discount factor $gamma = 1$ is acceptable since the utility is a finite sum, meaning no divergence. 

=== 
=== Multi-Agent Deep Deterministic Policy Gradient 
=== Multi-Agent Proximal Policy Optimisation