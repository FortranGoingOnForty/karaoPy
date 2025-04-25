
module dsp
  implicit none
contains

  subroutine mid_side(inbuf, outbuf, vocal_gain)
    ! inbuf      : real(8) array of length 2*N  (interleaved stereo: 
    !              L,R,L(ol),R,...)
    ! outbuf     : real(8) array, same length, to receive processed sam-
    !              -ples
    ! vocal_gain : real(8) scalar in [0,1]
    real(8), intent(in)  :: inbuf(:)
    real(8), intent(out) :: outbuf(:)
    real(8), intent(in)  :: vocal_gain
    integer :: i, n
    real(8) :: L, R, mid, side, out

    n = size(inbuf) / 2
    do i = 1, n
      ! extract left and right channels of frame i
      L    = inbuf(2*(i-1) + 1)
      R    = inbuf(2*(i-1) + 2)

      ! capture the mids and stereo-only shite
      mid  = 0.5d0 * (L + R)
      side = 0.5d0 * (L - R)

      ! if gain is 1.0, both instrumentals and vocals (as mid)
      ! otherwise 0.0, just instrumental, hope all goes well ;)
      out  = side + vocal_gain * mid

      ! writeback the mixed sample to the bout uffa
      outbuf(2*(i-1) + 1) = out
      outbuf(2*(i-1) + 2) = out
    end do
  end subroutine mid_side

end module dsp