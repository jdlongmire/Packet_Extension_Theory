-- PETTheory/Information.lean
-- Fisher Information Density Module (Phase 2)

import PETTheory.Basic

-- Gradient approximation for discrete implementation  
def gradientApprox (f : Position → ℝ) (pos : Position) (h : ℝ) : Position :=
  let dx := (f ⟨pos.x + h, pos.y, pos.z⟩ - f ⟨pos.x - h, pos.y, pos.z⟩) / (2 * h)
  let dy := (f ⟨pos.x, pos.y + h, pos.z⟩ - f ⟨pos.x, pos.y - h, pos.z⟩) / (2 * h)
  let dz := (f ⟨pos.x, pos.y, pos.z + h⟩ - f ⟨pos.x, pos.y, pos.z - h⟩) / (2 * h)
  ⟨dx, dy, dz⟩

-- Magnitude squared of gradient
def gradMagSq (grad : Position) : ℝ :=
  grad.x * grad.x + grad.y * grad.y + grad.z * grad.z

-- Fisher Information Density: Core PET Innovation
def fisherInfoDensity (ψ : WaveFunction) (pos : Position) (t : ℝ) (h : ℝ) : ℝ :=
  let ψVal := ψ pos t
  let ψAbs := if ψVal >= 0.0 then ψVal else -ψVal
  
  if ψAbs < 1e-12 then 0.0  -- Avoid division by zero
  else
    let gradψ := gradientApprox (fun p => ψ p t) pos h
    4.0 * (gradMagSq gradψ) / (ψAbs * ψAbs)
