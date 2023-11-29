## NERO: Non-parametric Entropy Rate Oracle

<img src="docs/ai_human.png" alt="AI Human" width="300" height="300">

## Description

Recognizing AI generated content by estimating the entropy rate of the symbol stream over the 26+1 letter alphabet (English).
We hypothesize that human generated content has a higher entropy rate. Shannon's experimental approach suggested that English has
an entropy rate of 1 bit / letter (`Shannon, Claude E. "Prediction and entropy of printed English." Bell system technical journal 30, no. 1 (1951): 50-64.`), and we show that AI generated content typically has much less.




<img src="docs/res.png" alt="AI Human" width="800">



## Example


```
MIN=5
L=10000
i='dracula.txt'
./src/gettext --i $i --o $i"_sym" --n
./entropy -c ../entropy-config2.cfg -f $i"_sym" -d 10000000 -m $MIN -x $L


```


## To Do

+ investigate a larget set of AI generated texts, with larger lengths
+ investigate the importance of the `MIN_OCCUR` variable and the `MAX_DEPTH`
+ create a standalone, python deployable tool
+ evaluate performance 
+ remove newline characters