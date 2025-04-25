
program dsp_driver
  use dsp
  implicit none

  integer :: N
  real(8), allocatable :: inbuf(:), outbuf(:)
  real(8) :: gain

  ! lil test: 2 frames of stereo
  N = 2
  allocate(inbuf(2*N), outbuf(2*N))

  inbuf = (/ 1d0, 2d0, 3d0, 4d0 /)
  gain = 0.5d0

  call mid_side(inbuf, outbuf, gain)

  print *, "inbuf :", inbuf
  print *, "outbuf:", outbuf

  deallocate(inbuf, outbuf)
end program dsp_driver