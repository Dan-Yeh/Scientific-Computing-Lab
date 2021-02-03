## worksheet2

| explicit Euler method |        |         |        |        |
|:---------------------:|:------:|:-------:|:------:|:------:|
|      $\delta$ t       |   1    |   0.5   |  0.25  | 0.125  |
|         error         | 0.7783 | 0.3827  | 0.1898 | 0.0945 |
|      error red.       |        |    y    |   y    |   y    |
|      error app.       | 0.6868 | 0.2888 | 0.0954 |   0    |

| method of Heun |        |        |        |        |
|:--------------:|:------:|:------:|:------:|:------:|
|   $\delta$ t   |   1    |  0.5   |  0.25  | 0.125  |
|     error      | 0.2749 | 0.0717 | 0.0189 | 0.0049 |
|   error red.   |        |   n    |   n    |   n    |
|   error app.   | 0.2701 | 0.0668 | 0.0140 |   0    |

| Runge-Kutta method |          |              |              |             |
|:------------------:|:--------:|:------------:|:------------:|:-----------:|
|     $\delta$ t     |   $1$    |    $0.5$     |    $0.25$    |   $0.125$   |
|       error        | $0.0079$ | $5.2249e-04$ | $3.4554e-05$ | $2.2331e-6$ |
|     error red.     |          |      n       |      n       |      n      |
|     error app.     |  0.0079  | $5.2024e-04$ | $3.2313e-5$  |      0      |

### Questions:

#### Q1 By which factor is the error reduced for each halfing of δt if you apply
* first order = 0.5
* second order = 0.25
* third order = 0.125
* fourth order = 0.0625
#### method

#### Q2 For which integer q can you conclude that the error of the
1. explicit Euler $q = 1$ :heavy_check_mark: 
2. method of Heun $q = 2$ :heavy_check_mark: 
3. Runge-Kutta (4-th order) $q = 4$ :heavy_check_mark: 
#### behave like O($\delta$t<sup>q</sup>)

#### Q3 Is a higher order method always more accurate than a lower order method (for the same stepsize δt)?
*Not excatly*  
* *If the dt is too small, then higher order method would not be much different with lower order method, because dt may close to machine epsilon, in this case the higher order method is useless due to restriction of floating points.*

* *If dt > 1, then higher order term would probably worse than lower order term, because the error is bounded by O(dt<sup>n</sup>), therefore n higher, the error is higher.*
#### Q4 Assume you have to compute the solution up to a certain prescribed accuracy limit and that you see that you can do with less time steps if you use the Runge- Kutta-method than if you use Euler or the method of Heun. Can you conclude in this case that the Runge-Kutta method is the most efficient one of the three alternatives?

*No, we cannot conlude.*
*Though the RK4 method have higher accuracy in less number of steps, but each RK4 step need more computational power than the other two, so it is hard to say which one is more efficient.*  
**Time = number_of_steps X time_needed_per_step**


