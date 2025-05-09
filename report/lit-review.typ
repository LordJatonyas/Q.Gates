#import "@preview/subpar:0.2.1"
#import "@preview/lovelace:0.3.0": *
#import "@preview/tablex:0.0.9": tablex, hlinex, vlinex, colspanx, rowspanx


= Literature Review
== Quantum Dot Devices
Alluded to in the previous section, a QD is a static potential well confined in 3D that traps electrons for qubit measurement. In the context of QD devices, employing the 2 dimensional electron gas (2DEG) model allows for more convenient discussions. 2DEG is the most important low-dimensional system for transport to the long mean free path of electrons at low temperature, and this is achieved through a combination of strain engineering and modulation doping in semiconductor heterostructures @low-dimen_semioconductors. On the 2DEG, electrons are free along the plane of the 2DEG surface, but are confined in the third direction. Formation of a QD on a 2DEG is verified by inspecting for large concentrations on a map of electrostatic potentials. The total electrostatic potential for every point in the 2DEG is modelled as the sum of components:

$ phi_(t o t) (r) = phi_g (r)  + phi_d (r) + phi_s (r) + phi_e (r) $ <2deg-model>

where the electrostatic potential contributions are gate potentials $phi_g$ from the gate electrodes following the pinned surface model, the disorder $phi_d$ from imperfections of random stuck electron charges during cooling (disorder), the surface potential $phi_s$ from the Fermi energy of the device, and electronic potential $phi_e$ from the presence of charges in the 2DEG, each term a function of position on the device. This thesis focuses on silicon-germanium (SiGe) heterostructures, and in this context, $phi_d$ is negligible and $phi_e$ comes from holes, not electrons.

 With reference to @single_qd_network, the single QD is connected to source and drain contacts via tunneling barriers. Each barrier can be modelled as a parallel connection between a tunneling capacitor and a tunneling resistor: $C_S$ with $R_S$ for the source and $C_D$ with $R_D$ for the drain. The QD is also connected to a gate electrode via capacitance $C_G$, and the electrode provides an overall control mechanism for the tunneling of electrons into the QD via gate potential $V_G$ @gate_controlled_qd.

#subpar.grid(
  figure(image("images/single_quantum_dot.svg", width: 57%), caption: [
    Single QD
  ]), <single_qd_network>,
  figure(image("images/double_quantum_dot.svg", width: 80%), caption: [
    Double QD
  ]), <double_qd_network>,
  rows: (10em, 10em),
  row-gutter: 3em,
  caption: [Networks of tunneling resistors and capacitors in QD architectures.],
  label: <qd_network>,
)

This model can be extended to architectures that capture more qubits, such as the double quantum dot in @double_qd_network. In this scenario, the coupling between the QDs can be characterised by interdot capacitance $C_M$ and resistance $R_M$. Gate electrode connections are similar to the previous case, each QD being connected via a capacitance. In practical systems, more gate electrodes are utilised to effectively control qubits.

#subpar.grid(
  figure(image("images/double_qd_sem.jpg", width: 55%), caption: [
    Scanning electron microscope (SEM) image of a Si/SiGe double QD device
  ]), <sem_double_qd>,
  figure(image("images/double_qd_cross-sec.jpg", width: 75%), caption: [
    #text([Cross-sectional view highlighting QD positions])
  ]), <cross-sec_double_qd>,
  show-sub-caption: (num, it) => {
    set par(justify: false, leading: 1em)
    num
    it.body
  },
  columns: (1fr, 1fr),
  propagate-supplement: false,
  caption: [Si/SiGe double quantum dot device.],
  label: <qd_sisige>,
)

A functioning architecture will have well-defined QD locations as shown in @sem_double_qd, verified by distinct qubits captured in @cross-sec_double_qd @quantum_computing_circuits_devices. Therefore, the electrostatic potential map on the silicon substrate serves as a useful premise for QD formation performance measurement.


== Gate Electrodes
=== Gate Types
Gate electrodes are fabricated as metallic layers (typically aluminium or polysilicon) deposited on top of the heterostructure stack that can control and shape the electrostatic potential landscape within the semiconductor heterostructure @quantum_computing_circuits_devices. In practical QD devices, gate electrodes are usually classified into three common types: plunger, barrier, and accumulation/reservoir. Their differences lie in size and voltage, with typical values listed in @typical_gate_properties @threshold_voltage @uniformity_control. The limit of 4V on each gate is found empirically and serves to prevent leakage.

#figure(
  supplement: [Table],
  tablex(
    columns: 4,
    align: center + horizon,
    auto-vlines: false,
    repeat-header: true,

    /* --- header --- */
    rowspanx(2)[*Gate Type*], colspanx(3)[*Typical Properties*], (), [*Width*], [*Voltage Range*], [*Max/Stress Voltage*], (),
    /* -------------- */

    [Plunger], [100 - 150 nm], [0.5 - 2 V], [4 V],
    [Barrier], [30 - 50 nm], [0.5 - 2 V], [4 V],
    [Accumulation/Reservoir], [100 - 200 nm], [1 - 2 V], [4 V],
  ),
  kind: table,
  caption: [Typical properties of different gate electrode types.],
) <typical_gate_properties>

#emph[Plunger gates] are typically larger electrodes placed directly above the intended QD region. Their primary function is to tune the electrochemical potential of the dot, thereby controlling the number of electrons or holes confined within it. By adjusting the voltage on the plunger gate, researchers can load or unload single charges and finely control the dot's energy levels. The ideal scenario involves a 1:1 relation between the number of QDs and the number of plunger gates above the heterostructure. This is essential for initialising, manipulating, and reading out spin qubits in quantum computing.

#emph[Barrier gates] are narrow electrodes positioned on either side of the plunger gate. They create tunable tunnel barriers between the QD and the source/drain reservoirs or between adjacent QDs. By varying the voltages on these gates, the tunneling rates can be precisely controlled, allowing for the isolation of the QD or the coupling between QDs for two-qubit operations. The interplay between plunger and barrier gates enables the formation of well-defined, controllable QDs with high-fidelity charge and spin manipulation.

#emph[Accumulation/Reservoir gates] are used to accumulate carriers in the source and drain reservoirs adjacent to the QD. They ensure a steady supply of electrons or holes to the device and can help in tuning the chemical potential of the reservoirs relative to the QD.


=== QD Architecture
Si/SiGe heterostructures are widely used for QD devices due to their high electron mobility, compatibility with silicon fabrication, and tunable quantum confinement @quantum_computing_circuits_devices. These devices typically employ a 2DEG formed at the interface of a strained Si quantum well sandwiched between SiGe barriers as illustrated in @cross-sec_double_qd. Electrostatic gates patterned above the heterostructure in @sem_double_qd define QDs by depleting carriers in specific regions.

The architecture of a QD device in Si/SiGe heterostructures is defined by the spatial arrangement and functional interplay of gate electrodes. The primary choice is a linear arrangement of gates which involves two barrier gates flanking a central plunger gate, with optional accumulation/reservoir gates further out. @sem_double_qd demonstrates the use of this in the double QD case where the barrier-plunger-barrier configuration is concatenated twice on the top half of the SEM image to achieve two QDs, while the larger accumulation/reservoir gates lie on the far ends of this arrangement. This also works for the single QD case.

To deal with the capacitive crosstalk between gate electrodes that is not reflected in @qd_network @dot-arrays_sige, practical systems typically require more than just a barrier-plunger-barrier configuration to realise a QD (not always 1:1 correspondence). Ultimately, it is the complex electrostatic interactions among different gate electrodes based on gate potential and gate positioning that define the properties of the QD formed.


== Multi-Agent Reinforcement Learning
Reinforcement learning is a paradigm in machine learning where an agent learns optimal behaviour through trial-and-error interactions with an environment @sutton_barto. It relies on reward signals and not labelled datasets for learning (unlike supervised learning), and has explicit feedback in the form of rewards, penalties, and predefined goals (unlike unsupervised learning). This paradigm is most suitable for the task of designing optimal gate electrode layouts due to the need for physics-based feedback, but lack of sufficient "correct" and optimal layouts.

#figure(
  image("images/marl.png", height: 220pt),
  caption: [Schematic of multi-agent reinforcement learning.],
) <multi_agent_rl>

By treating each gate electrode as an agent, the problem can be modelled using multi-agent reinforcement learning (MARL), in which optimal strategies are learnt for a set of agents in a multi-agent setting @mal. @multi_agent_rl highlights the main differences of this model from single-agent reinforcement learning, notably the joint action which is a combination of the individual actions by different agents, and the separate observation-reward pairs that inform each agent of its next best action @marl. Over multiple iterations or #emph[episodes], agents begin to learn strategies that map states to actions, otherwise known as #emph[policies].

To fully specify solutions to the problem, it is useful to consider the type of #emph[game model] that would most accurately describe the layout design problem. In reinforcement learning, game models can be organised hierarchically based on the number of agents, the number of states present, and the level of observability for these states by every agent as demonstrated in @game_models @marl. The layout design problem can be described as having $n$ agents (gate electrodes) and $m$ states (potential maps). These features already categorise the problem in the outer two sets of @game_models: #emph[stochastic games] and #emph[partially observable stochastic games], where observability refers to what individual agents can observe about their environment @marl. Assessing the level of observability would help decide which of the two sets best fits the problem.

#figure(
  image("images/marl_hierarchy.png", height: 190pt),
  caption: [Hierarchy of game models.],
) <game_models>

At its crux, states in the design problem are largely defined by the electrostatic interactions between gate electrodes @spin-qubits. These can be modelled using physics in a way that is unobstructed to all gate electrodes. However, a view of the entire electrostatic map is unnecessary given that each gate electrode only exerts an influence in its locality. Another consideration is the knowledge of other agents' actions and rewards. Though trivial (since practical single QD designs only include < 10 gate electrodes), only neighbouring gate electrode information is necessary for a gate electrode to decide on the optimal action to take. This means that only a partial view of the full environment is necessary for every gate electrode, so the design problem can be more accurately modelled by a partially observable stochastic game.


=== Partially Observable Stochastic Games
The overall stochastic game model was introduced by Shapley to address the need for a general framework that could model dynamic interactions among multiple decision-makers where the state changes in response to the players' choices @stochastic-games. As mentioned previously, the most suitable game model to tackle the layout design problem with is the partially observable stochastic game. To achieve this, the stochastic game model needs to be extended using partial observations and a #emph[finite-horizon].

For $M$ agents, a finite-horizon partially observable stochastic game is defined by a set of states $S$ describing a finite set of possible configurations of all agents, a set of actions $A_1$, ..., $A_M$ and a set of observations $O_1$, ..., $O_M$ for each agent over a fixed number of training episodes @maddpg.  Each agent $i$ uses a stochastic policy $pi_theta$ : $O_i times A_i |-> [0, 1]$ to choose an action, which produces the next state following the state transition function $T$ : $S times A_1 times$ ... $times A_N |-> S$. Each agent $i$ gets a reward which is a function of the state and the agent's action $r_i$ : $S times A_i |-> RR$, as well as a private observation correlated with the state $o_i$: $S |-> O_i$. The goal for each agent $i$ is to maximise its own total expected return, which is defined as:

$ R_i = sum_(t=0)^Tau gamma^t r_i^t $ <expected_return>

where $gamma$ is a discount factor that informs the amount of importance placed on future rewards (e.g. $gamma = 0 ->$ future rewards are not considered at all) and $Tau$ is the time horizon. Since the time horizon is finite in a finite-horizon game, a discount factor $gamma = 1$ is allowed as the return $R_i$ is a finite sum for each agent $i$, meaning no divergence.


=== On-policy versus Off-policy
Reinforcement learning hinges on the interplay between exploration and exploitation, guided by policies that dictate an agent's behaviour as previously described. Two foundational paradigms govern how policies are updated: #emph[on-policy] and #emph[off-policy] learning @sutton_barto.

In on-policy learning, the agent strictly refines its policy $pi$ using data generated by the same policy. This means that every update reflects the agent's current strategy, including its exploration mechanisms (e.g. $epsilon$-greedy action selection). The framework's defining feature is its alignment, where the behaviour policy (which collects data) and the target policy (which is optimised) are identical.

The benefit of such methods is that they are inherently stable; by relying on data from the current policy, they avoid distributional shift where outdated or mismatched data leads to divergent updates. Additionally, on-policy approaches naturally account for exploratory actions, ensuring that the policy's exploration strategy is baked into its learning process. However, they suffer from sample inefficiency, as they need to discard data from prior policies, constantly refreshing their interactions with the environment. Furthermore, their reliance on the current policy's exploration limits their ability to learn from diverse or suboptimal historical data, which can slow convergence. In MARL, on-policy methods ensure that agents adapt synchronously, as policies evolve using data from the current joint strategy. However, scalability suffers as coordination demands grow.

Off-policy learning, unlike on-policy, decouples the behaviour policy from the target policy. This separation enables agents to learn from diverse data sources, including exploratory policies or other agent's experiences. By reusing historical data (e.g. through replay buffers), they drastically reduce the need for real-time interaction, making them ideal for applications where data collection is costly. They also support flexible exploration where agents can adopt aggressive exploration strategies without compromising the target policy's optimisation. In MARL, this decoupling becomes especially powerful as agents can learn from others' behaviours or past interactions. However, they are prone to instability. Learning from mismatched data distributions introduces variance, particularly when the the behaviour policy poorly covers the target policy.

These tradeoffs directly shape algorithms like Multi-Agent Proximal Policy Optimisation (on-policy) and Deep Q Network (off-policy), as explored in the subsequent sections, which operationalise these frameworks in cooperative and competitive multi-agent environments.


=== Multi-Agent Proximal Policy Optimisation
Proximal Policy Optimisation (PPO) is a state-of-the-art on-policy algorithm that addresses the instability of traditional policy gradient methods. It constrains policy updates to prevent drastic changes. PPO's innovation lies in alternating between sampling data through interacting with the environment and optimising a clipped surrogate objective function shown in @ppo-objective which limits the policy update magnitude using stochastic gradient descent @ppo.

$ L(theta) = E[min(r_t (theta) hat(A)_t, c l i p(r_t (theta), 1 - epsilon, 1 + epsilon) * hat(A)_t)] $ <ppo-objective>

where $r_t (theta)$ is the probability ratio of the new policy to the old policy $(pi_theta (a_t | s_t))/(pi_theta_(o l d) (a_t | s_t))$, $hat(A)_t$ is the advantage function at timestep $t$, and $epsilon$ is a hyperparameter that controls the range of allowed policy changes.

Multi-Agent Proximal Policy Optimisation (MAPPO) is an extension of the single-agent Proximal Policy Optimisation (PPO) algorithm tailored for MARL. It trains two separate neural networks: an actor network with parameters $theta$ and a critic network with parameters $phi$ @mappo. A recurrent neural network (RNN) implementation of MAPPO is shown in Algorithm 1, which assumes that all agents share the critic and actor networks. The critic network $V_phi$ maps $S --> RR$ and the actor network $pi_theta$ maps $O --> A$.

#align(center,
  pseudocode-list(
    booktabs: true,
    title: [*Algorithm 1:* Multi-Agent Proximal Policy Optimisation],
    line-numbering: none,
    indentation: 2em
  )[
    + Initialise $theta$ and $phi$
    + Set learning rate $alpha$
    + *while* $s t e p <= s t e p_(m a x)$ *do*
      + set data buffer $D = {}$
      + *for* i = 1 to batch_size *do*
        + $tau$ = [ ] empty list
        + initialise $h_(0, pi)^((1)), ... , h_(0, pi)^((n))$ actor RNN states
        + initialise $h_(0, V)^((1)), ... , h_(0, V)^((n))$ actor RNN states
        + *for* t = 1 to T *do*
          + *for* all agents a *do*
            + $p_t^((a)), h_t^((a)) = pi (o_t^((a)), h_(t-1, pi)^((a)); theta)$
            + $u_t^((a)) ~ p_t^((a))$
            + $v_t^((a)), h_(t, V)^((a)) = V (s_t^((a)), h_(t-1, V)^((a)); phi)$
          + *end for*
          + Execute actions $u_t$, observe $r_t, s_(t+1), o_(t+1)$
          + $tau <-- tau + [s_t, o_t, h_t^((pi)), h_t^((V)), u_t, r_t, s_(t+1), o_(t+1)]$
        + *end for*
        + Compute advantage estimate $hat(A)$ via GAE on $tau$, using PopArt
        + Compute reward-to-go $hat(R)$ on $tau$ and normalize with PopArt
        + Split trajectory $tau$ into chunks of length $L$
        + *for* $l = 0, 1, ..., T/L$ *do*
          + $D = D union (τ[l : l+T], hat(A)[l : l+L], hat(R)[l : l+L])$
        + *end for*
      + *end for*
      + *for* mini-batch k = 1, ..., $K$ *do*
        + $b$ ← random mini-batch from $D$ with all agent data
        + *for* each data chunk $c$ in mini-batch $b$ *do*
          + update RNN hidden states for $pi$ and $V$ from first hidden state in data chunk
        + *end for*
        + Adam update $theta$ on $L(theta)$ with data $b$
        + Adam update $phi$ on $L(phi)$ with data $b$
      + *end for*
    + *end while*
  ]
)

In this algorithm, PopArt is an adaptive normalisation technique to normalise the targets used in the learning updates @popart. Its two main components are:
- *Adaptively Rescaling Targets (ART)*: to update scale and shift such that the target is appropriately normalised, and
- *Preserving Outputs Precisely (POP)*: to preserve the outputs of the unnormalised function when changing the scale and shift.


=== Deep Q-Networks
Deep Q-Networks (DQN) are convolutional networks trained using Deep Q-Learning which is an off-policy algorithm that uses a replay buffer to store experiences and use them to update the overall network @dqn.


#align(center,
  pseudocode-list(
    booktabs: true,
    title: [*Algorithm 2: Multi-Agent Deep Q Network*],
    line-numbering: none,
    indentation: 2em
  )[
    + Initialise Q-networks $theta_i$ for each agent $i$
    + Initialise target Q-networks $theta_i ' <- theta_i$ for each agent $i$
    + Initialise replay buffer $D$
    + *for* episode = 1 to $M$ *do*
      + Initialise environment and receive initial state $s_1$
      + *for* t = 1 to max_episode_length *do*
        + *for* each agent $i$ *do*
          + Select action $a_i$ using $epsilon$-greedy policy from $Q_i(s, a_i; theta_i)$
        + *end for*
        + Execute joint action $a = (a_1, ..., a_N)$, then observe reward $r$ and the next state $s'$
        + Store $(s, a, r, s')$ in replay buffer $D$
        + $s <- s'$
        + *for* each agent $i$ *do*
          + Sample random minibatch of transitions $(s, a, r, s′)$ from $D$
          + Set target $y = r_i + gamma max_(a_i ′) Q_i′(s′, a_i ′; theta_i ′)$
          + Update θᵢ by minimizing loss: $(y - Q_i (s, a_i; theta_i))^2$
        + *end for*
        + Every $c$ steps, update target networks: $theta_i ' <- theta_i$ for all $i$
      + *end for*
    + *end for*
  ]
)

Previous work in the Quantum Device Lab (Natalia Ares) has shown that DQN can be used to solve the layout design problem when more complex gate electrode geometries are allowed. This algorithm learnt optimal policies for individual gate electrodes, which then performed the actions of removing/adding rows/columns to form a QD that is closest to the desired shape and position. This thesis aims to extend this work by adapting DQN to the multi-agent setting, and learning an overall optimal policy in a cooperative setting where the goal is to minimise the difference between the desired and actual QD shapes and positions.


#pagebreak()