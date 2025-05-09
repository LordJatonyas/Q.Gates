= Methodology
This thesis aims to specify MARL solutions to designing rectangular gate electrodes on top of the heterostructure stack. As a proof-of-concept project, the goal is to realise this for more feasible case of single QD devices.

== Strategy
=== Layout Initiation
To apply MARL to the design problem, there has to be an initial layout to work with. By setting initial positions and gate voltages, an initial electrostatic potential map can be calculated via the physical modelling to then estimate the hole density of the layout.

The initial setup is established through 2D SEM images (in PNG format) that describe a 1400nm $times$ 938nm window of the top view of the QD device. A scaling of 1.5px : 1nm is applied, meaning SEM images of dimension 934px $times$ 625px are required. In tackling the single QD case, the initial layout involves the barrier-plunger-barrier configuration on the bottom half of the SEM image along with 2 accumulation gates that cut across the middle as illustrated in @initial_configuration.

#figure(
  rect(image("images/complete_initial_configuration.png", width: 75%)),
  caption: [Initial gate electrode layout.],
) <initial_configuration>

This layout does not consider the 


=== Action Space
From the perspective of each gate electrode, three types of actions can be performed. #emph[Translation] refers to the horizontal or vertical movement of each gate electrode. #emph[Scaling] is the expansion or contraction of the gate electrode. #emph[Voltage change] can also be applied to each gate electrode, referring to the increase or decrease of the gate potential. To administer these actions, the action update algorithm needs to manipulate the gate electrodes based on the way they are represented computationally.

In this problem, gate electrodes are fed into the algorithm as SEM images where for any one SEM image, the coloured pixels form one gate electrode. Due to the pixel representation, positional changes applied to gate electrodes require the removal or addition of rows or columns of pixels in the SEM images. Through this observation, it is possible to reduce the number of actions by treating the translation and scaling actions as products of adding and removing rows or columns of pixels. This also solves the problem of translations that lead to spaces between the borders of the SEM image and the start of the gate electrode.

With this choice, the action space can be defined by $A$ = {add left column, remove left column, add right column, remove right column, add top row, remove top row, add bottom row, remove bottom row, increase gate potential, decrease gate potential}, where $abs(A) = 10$.


=== State Estimation
Pixel-based physics modelling using @2deg-model, and then a suitable crop of the hole density map for each agent.

#figure(
  image("images/initial_state.png", width: 75%),
  caption: [Initial hole density state.],
) <initial_layout>


=== Constraints
Minkowski Sum

Necessary root at border


== Performance Measure
A series of quantitative metrics are used to evaluate the quality of the QD formed, thus assessing the success of the MARL algorithm. These also help to inform the design of the reward function.

=== Hausdorff Distance

=== Mean Difference


== Experimental Requirements
Due to the high costs associated with creating QD chips, this thesis only examines the feasibility of MARL methods through simulations.

#pagebreak()