# Copyright (C) 1995 John W. Eaton
# 
# This file is part of Octave.
# 
# Octave is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2, or (at your option) any
# later version.
# 
# Octave is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
# 
# You should have received a copy of the GNU General Public License
# along with Octave; see the file COPYING.  If not, write to the Free
# Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

function Y = ind2gray (X, map)

# Convert an octave indexed image to a gray scale intensity image.
#
# Y = ind2gray (X) converts an indexed image to a gray scale intensity
# image.  The current colormap is used to determine the intensities.
# The intensity values lie between 0 and 1 inclusive.
#
# Y = ind2gray (X, map) uses the specified colormap instead of the
# current one in the conversion process.
#
# SEE ALSO: gray2ind, rgb2ntsc, image, colormap

# Written by Tony Richardson (amr@mpl.ucsd.edu) July 1994.

  if (nargin < 1 || nargin > 2)
    usage ("ind2gray (X, map)");
  elseif (nargin == 1)
    map = colormap ();
  endif

# Convert colormap to intensity values.

  yiq = rgb2ntsc (map);
  y = yiq(:,1);

# We need Fortran indexing capability, but be sure to save the user's
# preference.

  pref = do_fortran_indexing;

  unwind_protect

    do_fortran_indexing = "true";

# Replace indices in the input matrix with indexed values in the output
# matrix.

    [rows, cols] = size (X);
    Y = y(X(:));
    Y = reshape (Y, rows, cols);

  unwind_protect_cleanup
    do_fortran_indexing = pref;
  end_unwind_protect

endfunction
