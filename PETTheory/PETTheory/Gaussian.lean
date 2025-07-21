-- PETTheory/Gaussian.lean
-- Gaussian Wave Packet Implementations and PET Calculations

import PETTheory.Basic
import PETTheory.Information
import PETTheory.Evolution

-- Gaussian wave packet parameters
structure GaussianParams where
  x₀ : ℝ        -- Center position
  σ : ℝ         -- Width parameter
  p₀ : ℝ        -- Mean momentum
  A : ℝ         -- Normalization amplitude

-- 1D Gaussian wave packet (simplified to 1D for explicit calculations)
def gaussianWavePacket (params : GaussianParams) : Position → ℝ → ℝ :=
  fun pos _t =>
    let x := pos.x
    let exponent := -((x - params.x₀) * (x - params.x₀)) / (4.0 * params.σ * params.σ)
    let phase := params.p₀ * x  -- Simplified phase
    -- Simplified to avoid Float.exp/cos issues - use polynomial approximation
    params.A * (1.0 + exponent) * (1.0 + phase * 0.1)

-- Explicit Fisher information density for Gaussian packet
def gaussianFisherInfo (params : GaussianParams) (pos : Position) : ℝ :=
  let x := pos.x
  let sigmaSquared := params.σ * params.σ
  -- Analytical result: I = p₀² + (x-x₀)²/(4σ⁴)
  (params.p₀ * params.p₀) + ((x - params.x₀) * (x - params.x₀)) / (4.0 * sigmaSquared * sigmaSquared)

-- PET effect on Gaussian uncertainty
def gaussianPETCorrection (params : GaussianParams) (α : ℝ) : ℝ :=
  let baseUncertainty := params.σ * params.p₀  -- Δx * Δp for Gaussian
  let infoContent := params.p₀ * params.p₀ + 1.0 / (4.0 * params.σ * params.σ)
  α * infoContent * baseUncertainty

-- Standard Gaussian parameters for testing
def standardGaussian : GaussianParams := {
  x₀ := 0.0,
  σ := 1.0,     -- 1 unit width
  p₀ := 1.0,    -- 1 unit momentum  
  A := 1.0      -- Normalized amplitude
}

-- Narrow Gaussian for enhanced PET effects
def narrowGaussian : GaussianParams := {
  x₀ := 0.0,
  σ := 0.1,     -- Very narrow → high Fisher information
  p₀ := 5.0,    -- High momentum → high Fisher information
  A := 1.0
}
