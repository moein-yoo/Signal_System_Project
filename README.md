# 🧩 From Power to Coupling: EEG Biomarkers of Cognitive Decline

**Signals and Systems – Sharif University of Technology**  
- 📅 Spring 2025  
- 👨‍🏫 Instructor: Prof. Hamid K. Aghajan  

---

## 📁 Repository Structure

```
📦 root/
├── 📁 Phase1/
│   ├── 📁 Functions/             # MATLAB helper functions for preprocessing & power analysis
│   ├── 📁 PreProcessed/          # Clean EEG data (Healthy, MCI, Mild AD)
│   │   ├── Healthy/
│   │   ├── MCI/
│   │   └── Mild/
│   ├── 📁 Results/               # STFT power outputs & group comparisons
│   └── 📄 main.m                 # Main script for Phase 1
│
├── 📁 Phase2/
│   ├── 📁 Functions/             # PAC extraction, MVL & MI computations, plotting utilities
│   ├── 📁 plots/                 # Generated figures (time courses, polar plots, histograms)
│   ├── 📁 PreProcessed/          # EEG .set files prepared in Phase 1
│   ├── 📄 mainn.m                # Main script for Phase 2
│   ├── 📄 PAC_all_subjects.mat   # Combined results (Healthy + MCI + Mild)
│   ├── 📄 PAC_Healthy.mat        # Subject-specific results
│   ├── 📄 PAC_MCI.mat
│   └── 📄 PAC_Mild.mat
│
├── 📄 SS_Proj_Ph1.pdf            # Phase 1 report — Power Analysis
├── 📄 SS_Proj_Ph2.pdf            # Phase 2 report — Phase-Amplitude Coupling (PAC)
└── 📄 README.md                  # Project overview & instructions
```

---

## 🧠 Project Overview

This two-phase EEG study investigates **olfactory-evoked brain dynamics** as potential biomarkers for **Alzheimer’s disease**.  
Using data from olfactory stimulation tasks, the analysis progresses:

- **Phase 1 – Power Analysis:**  
  Preprocess EEG signals and study time-frequency power changes (θ and γ bands) via **Short-Time Fourier Transform (STFT)**.

- **Phase 2 – Phase-Amplitude Coupling (PAC):**  
  Quantify how high-frequency (γ) amplitude is modulated by low-frequency (θ) phase using two metrics:
  - **Mean Vector Length (MVL)** – time-resolved coupling strength  
  - **Modulation Index (MI)** – structural specificity of coupling  

Together, they provide a cross-frequency view of neural coordination during sensory processing, revealing potential **EEG-based biomarkers of cognitive decline**.

---

## 🎯 Objectives per Phase

### **Phase 1 – EEG Power Analysis**
- Preprocess EEG using **EEGLAB** (filtering, ICA, epoching)
- Compute θ (4-8 Hz) and γ (30-50 Hz) power with **STFT**
- Compare odor-specific responses (🍫 chocolate vs 🌹 rose)
- Examine group differences among **Healthy, MCI, Mild AD**

### **Phase 2 – Phase-Amplitude Coupling (PAC)**
- Extract θ-phase and γ-amplitude using **Hilbert Transform**
- Compute time-resolved MVL and MI per trial → average per subject
- Generate **polar plots**, **time courses**, and **group comparisons**
- Perform electrode-wise PAC (e.g., Fp1/Fz/Pz analysis)
- Integrate and compare MVL vs MI interpretations

---

## 🛠️ Technologies Used

- **MATLAB R2023b** (+ EEGLAB 2025.0.0)
- **Signal Processing Toolbox**
- **Wavelet and Hilbert transforms**
- **Custom MATLAB Functions** for:
  - `compute_MVL`, `compute_MI`, `sliding_window_MVL`
  - Polar and histogram visualizations
  - Group-level plots and comparisons

---

## 🧩 Analytical Pipeline Summary

| Phase | Core Method | Main Bands | Output Type | Key Files / Folders |
|-------|--------------|-------------|--------------|---------------------|
| 1 | STFT Power Analysis | θ (4–8 Hz), γ (30–50 Hz) | Power vs time curves | `Results/`, `compute_power_stft.m` |
| 2 | PAC (MVL + MI) | θ ↔ γ coupling | Time-resolved MVL & MI, polar plots | `Functions/`, `plots/`, `mainn.m` |

---

## 📊 Sample Visual Outputs

- **Power Dynamics:** Event-locked θ and γ responses  
- **PAC Time Course:** MVL/MI curves (Healthy > MCI > Mild AD)  
- **Polar Plots:** Amplitude–phase histograms showing θ–γ alignment  
- **Group Comparisons:** Fp1/Fz/Pz channel-wise averages  

---

## 🧪 How to Run

### **Phase 1**
```matlab
cd Phase1
run('main.m')
```

### **Phase 2**
```matlab
cd Phase2
run('mainn.m')
```

Required MATLAB toolboxes: **Signal Processing**, **EEGLAB**, **Statistics**.  
All figures will be saved automatically inside the corresponding `Results/` or `plots/` folders.

---

## 📜 Reports

Full documentation, figures, and theoretical explanations are provided in:

- [`SS_Proj_Ph1.pdf`](SS_Proj_Ph1.pdf) – Power Analysis (Phase 1)  
- [`SS_Proj_Ph2.pdf`](SS_Proj_Ph2.pdf) – Phase-Amplitude Coupling (Phase 2)

---

## 👥 Contributors

**Authors**
- Kimia Fakheri  – [kimia.fakheri@gmail.com](mailto:kimia.fakheri@gmail.com)  
- Matin M. Babaei – [babaeimatin22@gmail.com](mailto:babaeimatin22@gmail.com)  

**By**  
- **Moein Yousefinia** – [moein.yoo84@sharif.edu](mailto:moein.yoo84@sharif.edu) | [moein_yoo@outlook.com](mailto:moein_yoo@outlook.com)

---

> This repository combines both phases of the *Signals and Systems* EEG project — transitioning from traditional power analysis to advanced phase-amplitude coupling.  
> It highlights how signal processing can illuminate neurophysiological coordination and contribute to early detection of cognitive impairment.
