## NERO: Non-parametric Entropy Rate Oracle

<img src="roc-entropy.png" alt="AI Human" width="400" >

## Description

Recognizing AI generated content by estimating the entropy rate of the symbol stream over the 26+1 letter alphabet (English).
We hypothesize that human generated content has a higher entropy rate. Shannon's experimental approach suggested that English has
an entropy rate of 1 bit / letter (`Shannon, Claude E. "Prediction and entropy of printed English." Bell system technical journal 30, no. 1 (1951): 50-64.`), and we found that  that AI generated content, with current LLM models, typically has much less. Thus, this approach of estimating the non-parametric entropy rate of a symbol stream gnerated by mapping text to teh described 27 letter alphabet is simulatenously a reliable detector of AI-generated test, as well as suggests the metrioc that future modifiactions of LLMs shoukld attempt to bet, particulalry to generate human-like longform material. In particular this requires no training. Since the idea is that we use the proposed algorithm to estimate the entropy rate of a given source, and that computed quantity is small for AI-generated material; no training is necessary.


However, the performance goes up even more, when we do employ some training as illustrated in teh next figure.

<img src="roc-classifier-green.png" alt="AI Human" width="400">

The basic algorithm was reported in a conference paper by Chattopadhyay and Lipson, at a time when its application in identifying AI-generated text  was
not a topic of interest, since the current sophisticated LLMs did not yet exist..


