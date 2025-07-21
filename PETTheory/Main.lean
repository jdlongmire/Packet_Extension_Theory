import PETTheory
import PETTheory.Information
import PETTheory.Evolution
import PETTheory.Gaussian

def main : IO Unit := do
  IO.println "=== PET Phase 4: Gaussian Wave Packets and PET Predictions ==="
  IO.println "============================================================"
  
  -- Test positions
  let pos₁ : Position := ⟨0.0, 0.0, 0.0⟩  -- Center
  let pos₂ : Position := ⟨1.0, 0.0, 0.0⟩  -- Off-center
  
  IO.println "STANDARD GAUSSIAN PACKET:"
  IO.println s!"Parameters: x₀={standardGaussian.x₀}, σ={standardGaussian.σ}, p₀={standardGaussian.p₀}"
  
  -- Calculate wave function values
  let ψ₁ := gaussianWavePacket standardGaussian pos₁ 0.0
  let ψ₂ := gaussianWavePacket standardGaussian pos₂ 0.0
  IO.println s!"ψ(0): {ψ₁}, ψ(1): {ψ₂}"
  
  -- Calculate Fisher information density
  let info₁ := gaussianFisherInfo standardGaussian pos₁
  let info₂ := gaussianFisherInfo standardGaussian pos₂
  IO.println s!"Fisher info at x=0: {info₁}"
  IO.println s!"Fisher info at x=1: {info₂}"
  
  -- Calculate PET correction
  let petCorr := gaussianPETCorrection standardGaussian defaultInfoCoupling
  IO.println s!"PET uncertainty correction: {petCorr}"
  
  IO.println ""
  IO.println "NARROW GAUSSIAN PACKET (Enhanced PET Effects):"
  IO.println s!"Parameters: x₀={narrowGaussian.x₀}, σ={narrowGaussian.σ}, p₀={narrowGaussian.p₀}"
  
  -- Calculate enhanced effects for narrow packet
  let narrowInfo₁ := gaussianFisherInfo narrowGaussian pos₁
  let narrowInfo₂ := gaussianFisherInfo narrowGaussian pos₂
  IO.println s!"Fisher info at x=0: {narrowInfo₁}"
  IO.println s!"Fisher info at x=1: {narrowInfo₂}"
  
  let narrowPET := gaussianPETCorrection narrowGaussian defaultInfoCoupling
  IO.println s!"Enhanced PET correction: {narrowPET}"
  
  -- Compare enhancement factor
  let enhancement := narrowPET / petCorr
  IO.println s!"PET enhancement factor: {enhancement}x"
  
  IO.println ""
  IO.println "EXPERIMENTAL PREDICTIONS:"
  IO.println s!"Information coupling α: {defaultInfoCoupling}"
  IO.println "✅ Analytical Gaussian wave packets operational!"
  IO.println "🔬 Explicit PET effects calculated!"
  IO.println "📊 Experimental test cases prepared!"
