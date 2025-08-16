                                16-Input Bit Mapping-Based OFDM Implementation on FPGA for High Data Rate Communication
🔹 Project Overview:

This project focuses on the design and FPGA implementation of an Orthogonal Frequency Division Multiplexing (OFDM) transceiver with 16-input bit mapping (16-QAM). The work targets high data rate wireless communication by leveraging the inherent advantages of OFDM — high spectral efficiency, multipath robustness, and parallel subcarrier transmission. The implementation is carried out on a Xilinx Zed-Board (Zynq SoC FPGA, xc7z020clg484-1) using Verilog HDL and synthesized in Xilinx Vivado 2024.1.2.

🔹 Motivation & Problem Statement:

With the exponential growth of digital communication, the demand for high-speed and reliable data transmission has increased drastically. Traditional Frequency Division Multiplexing (FDM) techniques suffer from interference between adjacent subcarriers and require guard bands, which reduce bandwidth efficiency.

OFDM solves this issue by ensuring orthogonality between subcarriers, allowing efficient bandwidth utilization and robustness against Inter-Symbol Interference (ISI) and Inter-Carrier Interference (ICI). This makes it a prime candidate for modern high-data-rate applications such as Wi-Fi, LTE, 5G, and cognitive radio systems.

🔹 System Design:

A. OFDM Transmitter:

The transmitter is responsible for modulating binary data into OFDM symbols and includes the following blocks:

1. Bit Stream Generator → produces a 4-bit sequence (0000 to 1111).

2. 16-QAM Modulator → maps 4 bits into 16 unique constellation points (amplitude & phase variations).

3. Symbol Modifier → concatenates QAM output to form a 64-bit sequence.

4. Zero Padder → inserts padding to fit IFFT input requirements (128 bits).

5. Inverse FFT (IFFT) → converts frequency-domain data to time-domain symbols (implemented as 8-point, radix-2, 16-bit IFFT).

6. Cyclic Prefixing → adds redundancy by copying a portion of the symbol to suppress ISI.

7. Serializer → converts the processed data into serial stream for transmission.

B. OFDM Receiver:

The receiver reconstructs the original input data:

1. Inverse Cyclic Prefixing → removes the prefix.

2. FFT → converts time-domain signal back to frequency domain.

3. Inverse Zero Padder → removes padded zeros.

4. Inverse Symbol Modifier → restores 16-bit QAM sequence.

5. De-mapper (QAM Demodulator) → retrieves the original 4-bit binary input.

🔹 Simulation & Implementation:

Design Tools: Xilinx Vivado 2024.1.2

-> Target Hardware: Zed-Board (Zynq-7000 SoC FPGA)

-> Design Language: Verilog HDL

-> Modules Verified: Both transmitter and receiver architectures were synthesized and simulated.

Results:

-> Transmitter successfully generates OFDM-modulated streams for all 16 possible input sequences.

-> Receiver accurately reconstructs the original 4-bit inputs after demodulation.

-> The design shows resilience to multipath effects due to cyclic prefixing.

🔹 Key Contributions:

✅ Full implementation of 16-QAM based OFDM transceiver in Verilog HDL.

✅ Efficient use of radix-2 FFT/IFFT algorithms for high-speed computation.

✅ Demonstrated successful synthesis and simulation on FPGA hardware (Zynq SoC).

✅ Provides a baseline design for future ASIC or FPGA-based wireless systems.

🔹 Applications:

-> 5G & Beyond Wireless Systems

-> High-Speed Wi-Fi (IEEE 802.11 family)

-> Cognitive Radio & Dynamic Spectrum Access

-> IoT-based Smart Communication

-> Secure Wireless Medical Data Transmission

🔹 Limitations & Future Work:

🔸 The current system uses 8-point FFT/IFFT — scalability to higher FFT sizes (64, 128, 1024) could enhance performance.

🔸 Channel estimation & equalization were not implemented — necessary for real-world deployment.

🔸 Power and resource optimization techniques (e.g., CORDIC-based FFT, partial reconfiguration) could further reduce FPGA utilization.

🔸 Future versions can integrate error correction codes (e.g., Turbo, LDPC) and MIMO-OFDM for reliability and higher throughput.

🔹 Conclusion:

This project successfully demonstrates a bit-mapped 16-QAM OFDM transceiver on FPGA, highlighting OFDM’s efficiency in high data rate communication. By combining spectral efficiency, multipath robustness, and FPGA hardware acceleration, the implementation lays a strong foundation for next-gen wireless communication systems.
