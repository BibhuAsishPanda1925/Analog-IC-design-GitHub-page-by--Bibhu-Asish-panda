# Analog Integrated Circuit (IC) Design
---------------------------------------------------------------------------------------

## Summer Internship course 2025
---------------------------------------------------------------------------------------
### COURSE OUTCOME
- Design of Analog ICs in the context of electronic system design
- Deriving IC specifications from the host electronic system.
- A good understanding of CMOS devices & technology.
- Proficiency in analog circuit design and analysis.
- Mastery of design tools: ngspice, xscheme, magic, netgen & Python.

### COURSE DETAIlL
***1. Introduction to an electronic system design, a plug-n-play USB-MIDI microphone.***
 - Microphone pre-amplifier and interface circuit design.
 - Select an widely available Op-Amp for the preamplifier e.g. TI OPA 344
 - Derive the important specs for the CMOS Op-Amp design.

***2. Introduction to linear circuits and passive devices***
 - Understanding passive devices (RLC) using basic EM principles.
 - Principle of linearity and superposition
 - Network analysis: KCL, KVL, node theorems, Thevenin, Norton
 - Emphasis on interfacing circuits and power transfer principle.

***3. Basics of MOS device physics***
 - Introduction to pn junctions.
 - MOS as capacitor.
 - Threshold voltage.
 - IV characteristics.
 - Parasitic capacitance.

***4. Basics of analog building blocks***
 - Current mirror design: simple, cascode and wide-swing mirrors
 -  Basic understanding of differential amplifiers.
 - Introduction to AC analysis: stability analysis of a 2-stage amplifier.
 - Design of a folded cascode amplifier using CMOS 130nm.

***5. Implementation of the design***
 - All the designs will be done using Skywater 130nm CMOS technology.
 - Schematic capture using open-source _xschem_.
 - Simulation will be done using _ngspice_.
 - Layout and final verification will be done using _magic_ and _netgen_.

### SOURCES & REFFERENCES
1. MEMS mic [Datasheet](https://cdn.sparkfun.com/assets/0/5/8/b/1/SPH8878LR5H-1_Lovato_DS.pdf)
2. OP-AMP-344 [Datasheet](https://www.ti.com/lit/ds/symlink/opa344.pdf?ts=1747822666491&ref_url=https%253A%252F%252Fwww.google.com%252F)
3. Mic module [Product](https://www.sparkfun.com/sparkfun-analog-mems-microphone-breakout-sph8878lr5h-1.html)
4. Mic module schematic [Schematic](https://cdn.sparkfun.com/assets/7/5/6/e/d/SparkFun_Analog_MEMS_Microphone_Breakout_SPH8878LR5H-1.pdf)


-------------------------------------------------------------------------------------------------------------------------------------------------------

### Day: 1-5 
***Calculating Thevenin Equivalent of Microphone***

Key specs from the microphone [Datasheet](https://cdn.sparkfun.com/assets/0/5/8/b/1/SPH8878LR5H-1_Lovato_DS.pdf) and research:
- Sensitivty: -44 dBV/Pa
- Condition: 94 dB SPL at 1 kHz which is sound pressure of 1 Pa
- Normal voice conversation is typically 60 dB SPL
- **Vth Calculation**
  - Voice (Pa) = $10^{(60-94)/20} = 19.9\times 10^{-3} Pa$
  - Output (Vpk) = $\sqrt{2}\times V_{rms} = \sqrt{2}\times 19.9\times 10^{-3} Pa \times 10^{-44/20} = 178 \mu Vpk$
  - **$V_{out-pk} = 0.178~ mV$**
- **Rth** (from datasheet) = 380 ohms.
  
**Thevenin equivalent circuit :**

<img src="https://github.com/silicon-vlsi/SI-2025-AnalogIC/blob/main/content/figures/Fig-d1-1-USBmic.png" width="800"/>
<img src="https://github.com/user-attachments/assets/0caa348b-773f-40ad-afa9-49c46f75d765" width="700"/>

**Transfer Function:**

$$
H(s) = \frac{v_{\text{out}}(s)}{v_{\text{in}}(s)} = -\left( \frac{s / R_i}{s + \frac{1}{R_i C_i}} \right)\left( \frac{1 / C_f}{s + \frac{1}{R_f C_f}} \right)
$$
$$
H(s) = - \left( \frac{\frac{s}{R_i}}{s + \frac{1}{R_i C_i}} \cdot \frac{\frac{1}{C_f}}{s + \frac{1}{R_f C_f}} \right)
$$

**From Sparkfun schematic:**
- Rin=5k, Rfb=300k, therefore Gain = 60
- So output of the amplfier will be 60x0.178 mVpk = **10.68 mVpk**
- Sparkfun site states **100 mVpk** probaby assuming 10 times higher input signal i.e. Voice is **80 dB SPL**
- Input high-pass frequency = $1/2\pi RC = 1/2\pi 5k 4.7uF = 6.77 Hz$
- Feedback Low-pass filter frequency = $1/2\pi RC = 1/2\pi 300k 27pF = 19.6kHz $
- Input common-mode filter = $1/2\pi 10k 1uF = 15.9 Hz$


#### ***Modeling of OP-AMP using VCVS***

<img src="https://github.com/user-attachments/assets/48b9ead1-8dc1-45e0-ae24-ba838738e79a" width="700"/>

<img src="https://github.com/user-attachments/assets/279f9559-ab76-4af9-a656-46ae5223f954" width="750"/>

- **AC simulation**
- **for a gain of 10000**
   - plot output voltage (in dB) and phase (in deg)
     
<img src="https://github.com/user-attachments/assets/dbf01d2b-0150-4c61-ac4c-7964d2e6516d" width="800"/>

<img src="https://github.com/user-attachments/assets/5eaacbd6-08e4-424c-b044-52926607f383" width="800"/>

   - measure the maximum gain and the frequency at the gain.
   - measure the -3 dB frequency and verify with your calaculation.
```
MAX-------------------- 35.37dB
3db-------------------- 32.37dB
f_pole----------------- 19.73kHz
f_zero----------------- 6.63Hz
f_mid------------------ 19.5Hz
ph_pole---------------- -135`
ph_zero---------------- -224.9`
ph_mid----------------- -161.3`
```
![image](https://github.com/user-attachments/assets/952c3c2d-812a-49ce-a457-4e1167524ae3)

#### ***Single-Pole model of OP-AMP***

<img src="https://github.com/user-attachments/assets/62e0f812-bd4e-4e0c-af81-68819033291e" width="1000"/>

<img src="https://github.com/user-attachments/assets/5a79d433-1df2-4d18-aaf7-cce058fc45b1" width="700"/>

<img src="https://github.com/user-attachments/assets/318f4244-fe1e-4242-abdc-b4f52f8bbbc9" width="700"/>

 ```
MAX-------------------- 34.91dB
3db-------------------- 31.91dB
f_pole----------------- 20.76kHz
f_zero----------------- 6.3Hz
f_60------------------ 151.42MHz
```
![image](https://github.com/user-attachments/assets/2dac6ff5-ca4e-4c68-9fe9-95caf9dc1285)


#### ***Modeling of OP-AMP using common source amplifier***

for the transistor sizing
| Parameter    | Increased by        | Trade-offs       |
| ------------ | ------------------- | ---------------- |
| Gain         | ↑ W, ↑ L            | Area, power      |
| Bandwidth    | ↓ L, ↑ bias current | Noise, power     |
| Output swing | ↑ L                 | Reduced speed    |
| Slew Rate    | ↑ W                 | More area, power |
| Noise        | ↑ W                 | Larger area      |


![image](https://github.com/user-attachments/assets/80758ac9-8841-4aca-a29f-2d535de27e99)

creating symbol for the OP-AMP

![image](https://github.com/user-attachments/assets/65bb60ce-42eb-4106-b2b0-cdbe5e9cc806)

simulating with mic_test circuit

![image](https://github.com/user-attachments/assets/4d2c897e-e341-4eab-a2cc-2fd607ad080f)

![image](https://github.com/user-attachments/assets/33f70c2b-d742-4e7f-9265-e0826d818cf0)

```
MAX-------------------- 21.83dB
3db-------------------- 18.83dB
f_pole----------------- 29.60kHz
f_zero----------------- 1.48Hz
```
![image](https://github.com/user-attachments/assets/f6c40115-8ad8-4fd8-892e-e0cfc5f23281)

Transient simulation

![image](https://github.com/user-attachments/assets/5845f64a-ea38-4d3b-a547-4e6476405403)

```
THD(Total Harmonic Distortion) = 28.52%
```

![image](https://github.com/user-attachments/assets/d4310898-a792-4a4a-85e1-f0abdfcc3c24)

***REVIEW :***
- From the OPA-344 datasheet the gain is 120dB and the THD is 0.06%.
1. For the common source differential amplifier which I have designed the gain is comming to be around 21dB which is very low.
2. The THD is 28.52%


----------------------------------------------------------------------------------------------------------------------------

The amplifier gain is very low so going for the telescopic amplifier.



