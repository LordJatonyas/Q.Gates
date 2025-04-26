#import "@preview/subpar:0.2.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/lovelace:0.3.0": *

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

By treating each gate electrode as an agent, the problem can be modelled using multi-agent reinforcement learning (MARL), in which optimal strategies are learnt for a set of agents in a multi-agent setting @mal. @multi_agent_rl highlights the main differences of this model from single-agent reinforcement learning, notably the joint action which is a combination of the individual actions by different agents, and the separate observation-reward pairs that inform each agent of its next best action @marl. Over multiple iterations or #emph[episodes], agents begin to learn strategies that map states to actions, otherwise known as #emph[policies].

#figure(
  image("images/marl.png", height: 190pt),
  caption: [Schematic of multi-agent reinforcement learning.],
) <multi_agent_rl>

To fully specify solutions to the problem, it is useful to consider the type of #emph[game model] that would most accurately describe the layout design problem. In reinforcement learning, game models can be organised hierarchically based on the number of agents, the number of states present, and the level of observability for these states by every agent as demonstrated in @game_models @marl. The layout design problem can be described as having $n$ agents (gate electrodes) and $m$ states (potential maps). These features already place the problem in the outer two sets of @game_models, but to decide between the two, state observability for each agent needs to be discussed.

At its crux, the problem of designing gate electrode layouts strongly ties to the modelling of the electrostatic physics. However, the full state 

This fits the #emph[stochastic game] model's description, therefore, MARL algorithms implemented in this thesis would be built on this game model.

#figure(
  image("images/marl_hierarchy.png", height: 190pt),
  caption: [Hierarchy of game models.],
) <game_models>

=== Stochastic Games
The stochastic game model was introduced by Shapley to address the need for a general framework that could model dynamic interactions among multiple decision-makers where the state changes in response to the players’s choices @stochastic-games. To ensure that this is compatible with practical requirements, a #emph[finite-horizon] game is considered for this thesis. For $M$ agents, a finite-horizon stochastic game is defined by a set of states $S$ describing a finite set of possible configurations of all agents, a set of actions $A_1$, ..., $A_M$ for each agent over a fixed number of training episodes @maddpg.  Each agent $i$ uses a stochastic policy $pi_theta$ : $S_i times A_i |-> [0, 1]$ to choose an action, which produces the next state following the state transition function $T$ : $S times A_1 times$ ... $times A_N |-> S$. Each agent $i$ gets a reward which is a function of the state and the agent's action $r_i$ : $S times A_i |-> RR$. The goal for each agent $i$ is to maximise its own total expected return $R_i = sum_(t=0)^Tau gamma^t r_i^t$ where $gamma$ is a discount factor and $Tau$ is the time horizon. Since the time horizon is finite in a finite-horizon game, a discount factor $gamma = 1$ is allowed as the return $R_i$ is a finite sum for each agent $i$, meaning no divergence.

=== Policy Gradient Algorithms

==== Multi-Agent Deep Deterministic Policy Gradient
Description of MADDPG.

The MADDPG algorithm is described below:

#figure(
  kind: "algorithm",
  supplement: [Algorithm],

  pseudocode-list(booktabs: true, numbered-title: [Multi-Agent Deep Deterministic Policy Gradient for $M$], line-numbering: none, indentation: 2em)[
    + *for* episode = 1 to $M$ *do*
      + Initialise a random process $N$ for action exploration
      + Receive initial state $upright(x)$
      + *for* t = 1 to max-episode-length *do*
        + for each agent $i$, select action $a_i = $*$mu_theta_i$*$(o_i) + N_t$ w.r.t. the current policy and exploration
        + Execute actions $a = (a_1, ... , a_N)$ and observe reward $r$ and new state $upright(x')$
        + Store (x, $a$, $r$, x') in replay buffer $D$
        + x $<--$ x'
        + *for* agent $i = 1$ to $M$ *do*
          + Sample a random minibatch of $S$ samples ($upright(x)^j, a^j, r^j, upright(x')^j$) from $D$
          + Set $y^j = r_i^j + gamma $

      + *end for*
    + *end for*
  ]
)


==== Multi-Agent Proximal Policy Optimisation

==== Comparison