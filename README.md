# Single-Stage Pipeline Register (Valid–Ready Handshake)

This repository contains a synthesizable SystemVerilog implementation of a
single-stage pipeline register using a standard valid–ready handshake protocol.

## Design Overview
The module sits between an input and output interface and provides:
1.One-stage storage
2.Proper backpressure handling
3.No data loss or duplication
4.Clean reset to an empty state

## Handshake Behavior
1.Data is accepted when `in_valid && in_ready`
2.Data is transferred when `out_valid && out_ready`
3.Allows simultaneous consume and refill in the same cycle

## Verification Notes
- SystemVerilog assertions are included to validate correct valid–ready behavior
- Assertions ensure:
  - `out_valid` remains asserted until data is accepted
  - Data transfer occurs only when both valid and ready are asserted
- Assertions are guarded using `ifdef ASSERTIONS` so they are active only during
  simulation and do not affect synthesis

## File Structure
rtl/pipeline_reg.sv



--Pavan Vootukuri.
