# model_input.jl

struct Model_input
    useCUDA::Bool
    #data_type
    nx::Int64
    ny::Int64
    nz::Int64
    Δx::AbstractFloat
    Δy::AbstractFloat
    Δz::AbstractFloat
    Δt::AbstractFloat
    tend::AbstractFloat
    K0::AbstractFloat
    h0::AbstractFloat
    u0::AbstractFloat
    v0::AbstractFloat
    w0::AbstractFloat
    source::AbstractFloat
    i_src::Int64
    j_src::Int64
    k_src::Int64
    duration::AbstractFloat
    const_recharge::AbstractFloat
    recharge_factor::AbstractFloat
end

#
# This function takes the model input
# Creates the model
#
function model_input()

    println("Reading model input ...")

    # Model size per dimension (-)
    nx   = 10
    ny   = 10
    nz   = 10

    # Grid sizes (m)
    Δx   = 100.0
    Δy   = 100.0
    Δz   = 10.0

    # Time step (s)
    Δt   = 100.0

    # hydraulic_conductivity (m/s)
    K0   = 1.0e-2

    # Initial condition
    h0   = 10.0    # (m)
    u0   = 0.0     # (m/s)
    v0   = 0.0     # (m/s)
    w0   = 0.0     # (m/s)

    # Source (well) data
    i_src  = 1
    j_src  = 1
    k_src  = 1
    duration = 0.0  # (s)
    source = 0.0    # (m3/s)

    # Rescharge data
    # QR_nb = I_nb * M_nb * A_n
    # with QR_nb in (L^3/T, or m3/s)
    # I is the unit rescharge flux (m/s)
    # A is the cell area for cell n
    # M is a multiplier/factor
    const_recharge = 5.0e-4    # (m3/s)
    recharge_factor = 1.0      # (-)

    # Test model:
    # 9 x 9 x 3: storage = 0.1x10-4
    # dx = dy = 10 m, dz = variable
    # recharge (N) of 5e-4
    # tend = 1Y (1D)?, dt = large

    # Simulation end time (s)
    tend = 10000.0

    # Backend selection
    println("Hit c for cuda...")
    c = readline()
    useCUDA = (c == "c")

    # Set corresponding data type
    # if useCUDA
    #     data_type = CuArray
    # else
    #     data_type = Array
    # end

    # Store the input in tuple "input"
    println("Grid specified: 3D grid with\n nx = ", nx, ",\n ny = ", ny, ",\n nz = ", nz, " and\n Δx = ", Δx, ",\n Δy = ", Δy, ",\n Δz = ", Δz)
    input = Model_input(useCUDA, nx, ny, nz, Δx, Δy, Δz, Δt, tend, K0, h0, u0, v0, w0, source, i_src, j_src, k_src, duration, const_recharge, recharge_factor)

end
