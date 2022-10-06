# Controllability of Original Turing RD Model

### Paper

**Paper：**

<br/>

### Dependencies

* Matlab
* Optimization Toolbox
* Image Ptocessing Toolbox

<br/>

### File Structure

```bash
|--DesignPattern.m
|--GetMatrix.m
|--Main.m
|--PlotResults.m
```

<br/>

### Usage

Run main.m to get the figures.

<br/>

### Note

- In the simulation, we computed the control from minimal energy using  *fmincon* in matlab.
- One can choose the control from one edge to eight edges. If the number of control is too small (comparing to the number of states), the simulation process(optimization process) can be very unstable and very sensitive to the parameters.
- Figure 3(b) and Figure 4(d) are not exactly the same. We included the boundary control in Figure 3(b) when we designed the final pattern but we only plotted the states when we plotted the simulation figures since the control can be changed freely. One can focus on the states in Figure 3(b) (without bounday control). Then Figure 3(b) and Figure 4(d) are the same.









