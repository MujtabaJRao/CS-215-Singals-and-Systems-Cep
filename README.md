# 🎸 Digital Guitar Sound Synthesis using Karplus–Strong Algorithm

## 📌 Overview
This project presents the modeling and implementation of a digital guitar sound synthesis system using the Karplus–Strong algorithm. It demonstrates how discrete-time signal processing techniques can be applied to simulate realistic plucked string sounds.

Developed as part of a Signals and Systems Course End Project (CEP), the work bridges theoretical DSP concepts with practical audio synthesis.

---

## 🧠 Background
The Karplus–Strong algorithm is a simple yet powerful method for simulating string vibration. It uses a combination of:
- Noise initialization (to simulate plucking)
- Delay lines (to represent string length)
- Feedback loops (to sustain oscillations)
- Filtering (to model energy loss)

This results in a decaying waveform that closely resembles the sound of a real string instrument.

---

## 🎯 Objectives
- Model the behavior of a vibrating string in discrete time  
- Implement the Karplus–Strong algorithm  
- Generate realistic guitar-like audio signals  
- Analyze the effect of parameters such as delay length and decay  

---

## ⚙️ Methodology
1. Initialize a buffer with random noise samples  
2. Continuously update the buffer using an averaging operation  
3. Feed the processed signal back into the system  
4. Output the signal as an audio waveform  

This iterative process produces a naturally decaying tone characteristic of plucked strings.

---


---

## 🛠️ Tools & Technologies
- Programming Language: * MATLAB *  
- Signal Processing Concepts: Discrete-Time Systems, Filtering, Feedback   

---

## ▶️ How to Run

### 🔊 Playing the Output
- The generated file `melody.wav` can be played using any standard media player such as MKV or VLC.

---

### 💻 Running the Code
- Open the file `code.m` in MATLAB  
- Run the script  

---

### 📁 Output Generation
- The program will generate:
  - Generate individual note audio files  
  - main  `melody.wav`  

 


---

## 🔊 Results
The system successfully generates synthesized guitar-like sounds.  
By adjusting parameters such as buffer size and feedback factor, different pitches and decay characteristics can be achieved.

---

## 📊 Key Learnings
- Practical implementation of DSP concepts  
- Understanding of feedback-based systems  
- Audio signal generation and manipulation  
- Connection between mathematical models and real-world signals  

---

## 🚀 Future Work
- Real-time audio playback  
- Graphical user interface for parameter tuning  
- Multi-string synthesis for full guitar simulation  
- Integration of audio effects (reverb, distortion)  

---

## 👥 Members
- *Muhammad Ahmed Qazi (CS-24045)*
- *Mujtaba Jawaid Rao (CS-24047)*  

---

## 📜 License
This project is developed for academic purposes as part of a university course.
