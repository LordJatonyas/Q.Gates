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

This layout is a combination of the individual gate electrodes. The input to the MARL algorithm would have each of these gate electrodes as separate SEM images. Notice that @initial_configuration does not consider the electrometer gates whose role is in the measurement of changes in the QD rather than in the formation of the QD @electrometer.


=== Action Space
From the perspective of each gate electrode, three types of actions can be performed. 
1. #emph[Translation] refers to the horizontal or vertical movement of each gate electrode. 
2. #emph[Scaling] is the expansion or contraction of the gate electrode. 
3. #emph[Voltage change] can also be applied to each gate electrode, referring to the increase or decrease of the gate potential.

To administer these actions, the action update algorithm needs to manipulate the gate electrodes based on the way they are represented computationally. In this problem, gate electrodes are fed into the algorithm as SEM images where for any one SEM image, the coloured pixels form one gate electrode. Due to the pixel representation, positional changes applied to gate electrodes require the removal or addition of rows or columns of pixels in the SEM images. 

Through this observation, it is possible to simplify the action space by treating the translation and scaling actions as combinations of adding and removing rows or columns of pixels. This also solves the problem of translations that lead to spaces between the borders of the SEM image and the start of the gate electrode.

With this choice, the action space can be defined by the action space $A$ where $abs(A) = 10$:
#grid(
  [
    - add/remove left column,
    - add/remove right column,
    - add/remove top row,
  ],
  [
    - add/remove bottom row,
    - increase/decrease gate potential.
  ],
  columns: 2,
  column-gutter: 7em,
)


=== State Estimation
The state of the system is the hole density distribution of the QD device. This is estimated by applying the physics model in @2deg-model to pixelated representation of the 934px $times$ 625px SEM image. An initial state estimate is obtained by doing this for the inital gate electrode layout in @initial_configuration, and its hole density map is shown in @initial_layout.

#figure(
  image("images/initial_state.png", width: 50%),
  caption: [Initial hole density state.],
) <initial_layout>

For each state update, the physics model is used to recalculate the hole density distribution. While this sounds computationally expensive, the estimation algorithm is optimised through just-in-time compilation. Furthermore, because of the nature of actions present in the action space, there is a large portion of the state space that does not change/reflect QD formation from one state to the next. For instance, the corners of the SEM image are not relevant for a central QD. This allows for a double optimisation: cropping of the SEM image for state estimation (seen in @initial_layout) and using cached results to populate regions with repeating values. These tremendously speeds up the estimation algorithm to just $~$ 2 seconds per state update.

As mentioned in @marl-lit-review, it is unnecessary for a gate electrode to have a full view of the hole density map to decide on an action to take in the next time step. Instead, a gate electrode only needs to know the hole density distribution of the area within a certain radius of the gate electrode. As such, for every state update $S$, the hole density map in @initial_layout can be cropped into regions of 100px $times$ 100px around the gate electrodes tips to serve as the observations $O_1, O_2, ..., O_5$. To include a cooperative aspect to the MARL reward, a crop of the QD itself (which lies close to the centre of the SEM image) should also be included. This need not serve as an observation for the gate electrodes, but will be processed using methods in @performance-lit-review to provide additional scalar rewards to the gate electrodes during centralised training.


=== QD Extraction
There are three relevant properties of a QD that help in automatically extracting it from a given hole density distribution (state). Firstly, a QD should be a closed shape and surrounded by sufficiently large areas of very low ( $< 2 times 10^(15)$ $upright(m)^(-2)$ ) hole densities. Secondly, the QD itself should have mid-range ( $~ 1 times 10^(16)$ $upright(m)^(-2)$ ) hole densities. Thirdly, the QD's diameter is on the order of magnitude of 10 nm, and keeping the size conservative translates to roughly < 50px in the hole density map image. In the case of a single QD with no electrometer gates, the extraction problem is greatly simplified as the QD is the only closed shape in the hole density map image. Furthermore, because it must be situated above the plunger gate, between the barrier gates, and below the accumulation gates, the QD is predictively bounded by the observation crops $O_1, O_2, ..., O_5$.

Using these, an algorithm for QD extraction from a given estimated state can be formulated. This is applied to a central crop of the hole density map image which lies vertically between the centre of the uppermost accumulation gate and the middle of the plunger gate, and horizontally between the centres of the barrier gates as shown in @central_crop.

#figure(
  image("images/central_crop_combined.png", width: 100%),
  caption: [Central crop for QD extraction.],
) <central_crop>

The QD extraction algorithm first performs a thresholding operation to filter out non-QD hole densities including the very low hole density regions. This eliminates bulk of the pixels in the central crop, leaving only the pixels that are likely to be constituent to a QD. The algorithm then finds a set of edge pixels to define the boundary of the region of interest. The edge pixels are found by checking each pixel's neighbourhood; if a pixel is missing a neighbouring pixel in any direction, it is added to the set. This set is then used to check that the region of interest has a largest difference between two edge pixels that does not violate the third property, and if it does, a penalty that scales with the difference between ideal and actual diameters is applied.

By relying on just the crop in @central_crop for analysis of the QD, the number of pixels involved in QD extraction is significantly reduced. This means that even with a time complexity of $O(n^2)$ (due to the diameter checking operation), the QD extraction algorithm is still very fast per state update.


=== Constraints
So far, the description of the MARL algorithm has not considered any physical constraints. An important constraint is that gate electrodes must emerge from the borders of the SEM image. The reason for this is that this 934px $times$ 625px window is ultimately a crop of the entire top layer of the QD device, and so gate electrodes actually extend beyond these borders to connect to voltage sources as suggested in @single_qd_network.

There is also a constraint on the voltage applied to the gate electrodes. This is indicated in @typical_gate_properties where gate potentials cannot exceed 4V as doing so would lead to leakage and also threatens to damage the device. This constraint can be directly applied to the action space by clipping the voltage to between 0.5V and 4V. The lower voltage limit is to guarantee that each gate electrode is contributing to the formation of the QD, if not it would be pointless to even include that gate electrode in the design.

Additionally, gate electrodes should not be allowed to overlap with each other as this would imply a short circuit in the device. To account for this, a Minkowski Sum can be used to ascertain that a minimum distance of 15px (10nm) is maintained between any two adjacent gate electrodes by forming new shapes for easy collision detection shown in @minkowski_sum.

#figure(
  image("images/full_minkowski_sum.png", width: 70%),
  caption: [Full Minkowski Sum of initial configuration.],
) <minkowski_sum>

While @minkowski_sum shows the full Minkowski Sum of the initial configuration, collision checks are only done for one gate electrode at a time after it has been changed. That is why the algorithm would not need to do a Minkowski Sum for every gate electrode for every state update, and the Minkowski Sum needs to account for the full clearance of 15px as opposed to just half of it.

There are two properties of the layout problem description that helps to make collision detection even more efficient. Firstly, all gate electrodes are rectangular in shape. Secondly, only strictly vertical or horizontal electrode layouts are permitted. These two combine to make it sufficient for collision checks to be done only at the corners of the gate electrodes. As such, the Minkowski Sum can be adapted to look like @adapted_minkowski_sum.

#figure(
  image("images/adapted_minkowski_sum.png", width: 70%),
  caption: [Reduced Minkowski Sum of initial configuration.],
) <adapted_minkowski_sum>


== Performance Measures <performance-lit-review>
To evaluate the performance of a design generated by the MARL algorithms, a desired QD is set as a reference, and the QD formed in the simulation is compared to it using both region and boundary metrics. Together, these help to assess the quality of the gate electrode layout design and inform the design of the reward function.

=== Region Metrics
This thesis uses two different region metrics for evaluation, and these focus on the overlap between entire regions. #emph[Dice-Sorensen Coefficient] (DSC) measures the similarity of two regions by comparing their overlap relative to their combined size, defined as:

$ D S C = (2 (A ∩ B)) / (A + B) $ <dice_sorensen_coefficient>

where $abs(A)$ and $abs(B)$ are the number of pixels in regions $A$ and $B$, and $(A ∩ B)$ is the number of pixels in their intersection.

#emph[Tanimoto Coefficient] (TC), also known as the Jaccard Index, is slightly different in that it measures the similarity of two regions by comparing their overlap relative to their union:

$ T C = (A ∩ B) / (A ∪ B) $ <tanimoto_coefficient>

These two metrics are closely related, in that both are the same at extreme cases of (0, 1), and carry the relation $D S C = (2 T C) / (T C + 1)$, which further implies that $D S C > T C$ in between the extremes. In the context of the design problem, both DSC and TC can be used to evaluate the overlap performance between the QD formed using the MARL algorithm and a desired QD.

However, region metrics alone are insufficient as they do not account for local variations in shape, boundaries, and location of errors. There needs to be a complementary metric.


=== Boundary Metrics
Boundary metrics are suitable as complements to region metrics as they capture the separation between sets rather than the overlap. These metrics tend to rely on the distances between pixels in one set to the nearest pixels in another set. Given two sets $X = {x_1, x_2, ..., x_n}$ and $Y = {y_1, y_2, ..., y_m}$, the closest distance from each pixel $x_i$ to $Y$ can be calculated as:

$ d(x_i, Y) = min_(j = 1)^m abs(y_j - x_i) $

The #emph[Pompeiu-Hausdorff Distance] (HD) is a boundary metric that quantifies the maximum distance between any point in one set and the nearest point in another, effectively measuring the worst mismatch between two sets denoted by a scalar value:

$ H D (X, Y) = max({d(x_i, Y)}) $

In the design problem, $X$ is the QD formed by a MARL-generated layout, and $Y$ is the desired QD. HD is useful in assessing the overall shape and separation of the QD formed relative to the desired QD. The problem with this since HD is a scalar, for the same HD value, there could be multiple QDs shown in @hausdorff_weakness, some of which may be worse in terms of matching performance. This highlights the need for using complemetary metrics in combining both boundary and region metrics, as they cover different aspects of QD quality assessment.

#figure(
  image("images/hausdorff_weakness.png", width: 50%),
  caption: [Multiple QDs with the same HD value.],
) <hausdorff_weakness>



=== Reward Function
Quantitative metrics underscore the analysis of the MARL algorithms' performance in forming the desired QD. Therefore, on top of being evaluation tools, they also help to inform the design of the reward function.


== Experimental Requirements
Due to the high costs associated with creating QD chips, this thesis only examines the feasibility of MARL methods through simulations.

#pagebreak()