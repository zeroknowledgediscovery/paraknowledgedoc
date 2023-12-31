## NERO: Non-parametric Entropy Rate Oracle

Identify long-form AI-generated text using a training-free algorithm, that recognizes the
lower entropy rate of AI-generated text viewed as a symbol stream over a 26+1 letter alphabet

## Cloud Function Quickstart

```
curl -X POST -F "file=@FILEPATH" "https://us-central1-pkcsaas-01.cloudfunctions.net/nero?api_key=APIKEY"
```

<img src="roc-entropy.png" alt="AI Human" width="400" >
 
## Description

Recognizing AI generated content by estimating the entropy rate of the symbol stream over the 26+1 letter alphabet (English).
We hypothesize that human generated content has a higher entropy rate. Shannon's experimental approach suggested that English has
an entropy rate of 1 bit / letter (`Shannon, Claude E. "Prediction and entropy of printed English." Bell system technical journal 30, no. 1 (1951): 50-64.`), and we found that  that AI generated content, with current LLM models, typically has much less. Thus, this approach of estimating the non-parametric entropy rate of a symbol stream gnerated by mapping text to the described 27 letter alphabet is simulatenously a reliable detector of AI-generated test, as well as suggests the metrioc that future modifiactions of LLMs shoukld attempt to bet, particulalry to generate human-like longform material. In particular this requires no training. Since the idea is that we use the proposed algorithm to estimate the entropy rate of a given source, and that computed quantity is small for AI-generated material; no training is necessary.


However, the performance goes up even more, when we do employ some training as illustrated in the next figure.

<img src="roc-classifier.png" alt="AI Human" width="400">

The basic algorithm was reported in the following conference paper by Chattopadhyay and Lipson, at a time when its application in identifying AI-generated text  was
not a topic of interest, since the current sophisticated LLMs did not yet exist.


```
I. Chattopadhyay and H. Lipson, "Computing entropy rate of symbol sources & a distribution-free limit theorem," 2014 48th Annual Conference on Information Sciences and Systems (CISS), Princeton, NJ, USA, 2014, pp. 1-6, doi: 10.1109/CISS.2014.6814175.
```

## Overview of the underlying Entropy Rate Estimation Algorithm

Entropy rate of sequential data-streams naturally quantifies the complexity of the generative process. Thus entropy rate fluctuations could be used as a tool to recognize dynamical perturbations in signal sources, and could potentially be carried out without explicit background noise characterization. However, state of the art algorithms to estimate the entropy rate have markedly slow convergence; making such  approaches non-viable in practice. Leveraging a connection with probabilistic finite automata generators of symbolic streams, our approach realizes sunbstantially more relaible and faster entropy rate estimation, with provable convergence rates.