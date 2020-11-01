function numcomp = ccMagneticPolycubeAll(polys)
% input: polys is a cell array of (x,y,z) and color values for n magnetic cubes.
% Their color corresponds to the magnet configuration.
% output: numcomp is the number of connected components.  1 <= ncomp <= n
% Yitong Lu & Aaron Becker, Sept 9, 2020.

% % For example
% polys = [0,0,0,2;
%          0,1,0,0;
%          1,1,0,0;
%          1,2,0,1];

% polys = [0,0,0,2;
%          0,1,0,0;
%          1,1,0,0;
%          1,0,0,1];

% polys = [0,0,0,1;
%          0,1,0,1;
%          1,0,0,0;];

[n,c] = size(polys); %#ok<ASGLU> % polys is the poly we selected to check from cell arrays, n is number of cubes, c is color (last column)
group = 1:n; % group is the connected component associated with poly i.
% at the beginning, every poly is in it's own group.
% at the end, every poly in a connected component has the same group.
checked = zeros(1,n); % make a list of number of cubes we need to check

for i = 1:n
    if 0==checked(i)
        checked(i) = 1;  % we are now checking it
        [group,checked] = ccRecursion(i,polys,n,group,checked);
    end
end
numcomp = numel(unique(group)); % the number of components is the number of unique groups
end

function [group,checked] = ccRecursion(i,polys,n,group,checked)
for j = [1:i-1,i+1:n] % check all the other cubes
    if 0==checked(j)
        % for each unchecked  cube j, check if it is connected to cube i,
        if isConnected( polys(i,:), polys(j,:))
            checked(j) = 1; % mark as checked
            group(j) = group(i);
            [group,checked] = ccRecursion(j,polys,n,group,checked);
        end
    end
end
end

function bConnected = isConnected(cubeA, cubeB)
bConnected = false;

% if cubeA and cubeB are both red
if cubeA(1,end)==1 && cubeB(1,end)==1 && ...
    any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % same red color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are both Blue
if cubeA(1,end)==0 && cubeB(1,end)==0 && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % same blue color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are both cyan
if cubeA(1,end)==2 && cubeB(1,end)==2 && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % same cyan color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are both green
if cubeA(1,end)==3 && cubeB(1,end)==3 && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % same green color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are both yellow
if cubeA(1,end)==4 && cubeB(1,end)==4 && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % same yellow color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are both magenta
if cubeA(1,end)==5 && cubeB(1,end)==5 && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % same magenta color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are both black
if cubeA(1,end)==6 && cubeB(1,end)==6 && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % same black color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are both brown
if cubeA(1,end)==7 && cubeB(1,end)==7 && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % same brown color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are both orange
if cubeA(1,end)==8 && cubeB(1,end)==8 && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % same orange color can connect along x
    bConnected = true;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if cubeA and cubeB are red and blue
if ( (cubeA(1,end)==1 && cubeB(1,end)==0) || (cubeA(1,end)==0 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % red and blue color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==1 && cubeB(1,end)==0) || (cubeA(1,end)==0 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,2) == cubeB(1,2)+1) | (cubeA(1,2) == cubeB(1,2)-1) ) )  % red and blue color can connect along y
    bConnected = true;
elseif ( (cubeA(1,end)==1 && cubeB(1,end)==0) || (cubeA(1,end)==0 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,2) == cubeB(1,2) ) ) & ...
        ( (cubeA(1,3) == cubeB(1,3)+1) | (cubeA(1,3) == cubeB(1,3)-1) ) ) % red and blue color can connect along z
    bConnected = true; % red and blue can connect along any face
end

% if cubeA and cubeB are red and cyan
if ( (cubeA(1,end)==1 && cubeB(1,end)==2) || (cubeA(1,end)==2 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % red and cyan color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==1 && cubeB(1,end)==2) || (cubeA(1,end)==2 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,2) == cubeB(1,2)) ) & ...
        ( (cubeA(1,3) == cubeB(1,3)+1) | (cubeA(1,3) == cubeB(1,3)-1) ) ) % red and cyan color can connect along z
    bConnected = true;
end

% if cubeA and cubeB are red and green
if ( (cubeA(1,end)==1 && cubeB(1,end)==3) || (cubeA(1,end)==3 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % red and green color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==1 && cubeB(1,end)==3) || (cubeA(1,end)==3 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,2) == cubeB(1,2)+1) | (cubeA(1,2) == cubeB(1,2)-1) ) ) % red and green color can connect along y
    bConnected = true;
end

% if cubeA and cubeB are red and yellow
if ( (cubeA(1,end)==1 && cubeB(1,end)==4) || (cubeA(1,end)==4 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % red and yellow color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==1 && cubeB(1,end)==4) || (cubeA(1,end)==4 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,2) == cubeB(1,2)) ) & ...
        ( (cubeA(1,3) == cubeB(1,3)+1) | (cubeA(1,3) == cubeB(1,3)-1) ) ) % red and yellow color can connect along z
    bConnected = true;
end

% if cubeA and cubeB are red and magenta
if ( (cubeA(1,end)==1 && cubeB(1,end)==5) || (cubeA(1,end)==5 && cubeB(1,end)==1) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % red and magenta color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are red and black
if ( (cubeA(1,end)==1 && cubeB(1,end)==6) || (cubeA(1,end)==6 && cubeB(1,end)==1) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % red and black color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are red and brown
if ( (cubeA(1,end)==1 && cubeB(1,end)==7) || (cubeA(1,end)==7 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % red and brown color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==1 && cubeB(1,end)==7) || (cubeA(1,end)==7 && cubeB(1,end)==1) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,2) == cubeB(1,2)+1) | (cubeA(1,2) == cubeB(1,2)-1) ) ) % red and brown color can connect along y
    bConnected = true;
end

% if cubeA and cubeB are red and orange
if ( (cubeA(1,end)==1 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==1) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % red and orange color can connect along x
    bConnected = true;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if cubeA and cubeB are blue and cyan
if ( (cubeA(1,end)==0 && cubeB(1,end)==2) || (cubeA(1,end)==2 && cubeB(1,end)==0) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % blue and cyan color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are blue and green
if ( (cubeA(1,end)==0 && cubeB(1,end)==3) || (cubeA(1,end)==3 && cubeB(1,end)==0) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % blue and green color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==0 && cubeB(1,end)==3) || (cubeA(1,end)==3 && cubeB(1,end)==0) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,2) == cubeB(1,2)) ) & ...
        ( (cubeA(1,3) == cubeB(1,3)+1) | (cubeA(1,3) == cubeB(1,3)-1) ) ) % blue and green color can connect along z
    bConnected = true;
end

% if cubeA and cubeB are blue and yellow
if ( (cubeA(1,end)==0 && cubeB(1,end)==4) || (cubeA(1,end)==4 && cubeB(1,end)==0) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % blue and yellow color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==0 && cubeB(1,end)==4) || (cubeA(1,end)==4 && cubeB(1,end)==0) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,2) == cubeB(1,2)+1) | (cubeA(1,2) == cubeB(1,2)-1) ) ) % blue and yellow color can connect along y
    bConnected = true;
end

% if cubeA and cubeB are blue and magenta
if ( (cubeA(1,end)==0 && cubeB(1,end)==5) || (cubeA(1,end)==5 && cubeB(1,end)==0) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % blue and magenta color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==0 && cubeB(1,end)==5) || (cubeA(1,end)==5 && cubeB(1,end)==0) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,2) == cubeB(1,2)) ) & ...
        ( (cubeA(1,3) == cubeB(1,3)+1) | (cubeA(1,3) == cubeB(1,3)-1) ) ) % blue and magenta color can connect along z
    bConnected = true;
end

% if cubeA and cubeB are blue and black
if ( (cubeA(1,end)==0 && cubeB(1,end)==6) || (cubeA(1,end)==6 && cubeB(1,end)==0) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % blue and black color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are blue and brown
if ( (cubeA(1,end)==0 && cubeB(1,end)==7) || (cubeA(1,end)==7 && cubeB(1,end)==0) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % blue and brown color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are blue and orange
if ( (cubeA(1,end)==0 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==0) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % blue and orange color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==0 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==0) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,2) == cubeB(1,2)+1) | (cubeA(1,2) == cubeB(1,2)-1) ) ) % blue and orange color can connect along y
    bConnected = true;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if cubeA and cubeB are cyan and green
if ( (cubeA(1,end)==2 && cubeB(1,end)==3) || (cubeA(1,end)==3 && cubeB(1,end)==2) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % cyan and green color can connect along x
elseif ( (cubeA(1,end)==2 && cubeB(1,end)==3) || (cubeA(1,end)==3 && cubeB(1,end)==2) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,2) == cubeB(1,2)) ) & ...
        ( (cubeA(1,3) == cubeB(1,3)+1) | (cubeA(1,3) == cubeB(1,3)-1) ) ) % cyan and green color can connect along z
    bConnected = true;
end

% if cubeA and cubeB are cyan and yellow
if ( (cubeA(1,end)==2 && cubeB(1,end)==4) || (cubeA(1,end)==4 && cubeB(1,end)==2) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % cyan and yellow color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are cyan and magenta
if ( (cubeA(1,end)==2 && cubeB(1,end)==5) || (cubeA(1,end)==5 && cubeB(1,end)==2) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % cyan and magenta color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==2 && cubeB(1,end)==5) || (cubeA(1,end)==5 && cubeB(1,end)==2) )  && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,2) == cubeB(1,2)) ) & ...
        ( (cubeA(1,3) == cubeB(1,3)+1) | (cubeA(1,3) == cubeB(1,3)-1) ) ) % cyan and magenta color can connect along z
    bConnected = true;
end

% if cubeA and cubeB are cyan and black
if ( (cubeA(1,end)==2 && cubeB(1,end)==6) || (cubeA(1,end)==6 && cubeB(1,end)==2) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % cyan and black color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are cyan and brown
if ( (cubeA(1,end)==2 && cubeB(1,end)==7) || (cubeA(1,end)==7 && cubeB(1,end)==2) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % cyan and black color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are cyan and orange
if ( (cubeA(1,end)==2 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==2) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % cyan and black color can connect along x
    bConnected = true;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if cubeA and cubeB are green and yellow
if ( (cubeA(1,end)==3 && cubeB(1,end)==4) || (cubeA(1,end)==4 && cubeB(1,end)==3) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % green and yellow color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==3 && cubeB(1,end)==4) || (cubeA(1,end)==4 && cubeB(1,end)==3) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,2) == cubeB(1,2)+1) | (cubeA(1,2) == cubeB(1,2)-1) ) )  % green and yellow color can connect along y
    bConnected = true;
elseif ( (cubeA(1,end)==3 && cubeB(1,end)==4) || (cubeA(1,end)==4 && cubeB(1,end)==3) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,2) == cubeB(1,2) ) ) & ...
        ( (cubeA(1,3) == cubeB(1,3)+1) | (cubeA(1,3) == cubeB(1,3)-1) ) ) % green and yellow color can connect along z
    bConnected = true; % green and yellow can connect along any face
end

% if cubeA and cubeB are green and magenta
if ( (cubeA(1,end)==3 && cubeB(1,end)==5) || (cubeA(1,end)==5 && cubeB(1,end)==3) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % green and magenta color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are green and black
if ( (cubeA(1,end)==3 && cubeB(1,end)==6) || (cubeA(1,end)==6 && cubeB(1,end)==3) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % green and black color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are green and brown
if ( (cubeA(1,end)==3 && cubeB(1,end)==7) || (cubeA(1,end)==7 && cubeB(1,end)==3) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % green and brown color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are green and orange
if ( (cubeA(1,end)==3 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==3) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % green and orange color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==3 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==3) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,2) == cubeB(1,2)+1) | (cubeA(1,2) == cubeB(1,2)-1) ) ) % green and orange color can connect along y
    bConnected = true;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if cubeA and cubeB are yellow and magenta
if ( (cubeA(1,end)==4 && cubeB(1,end)==5) || (cubeA(1,end)==5 && cubeB(1,end)==4) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) ) % yellow and magenta color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==4 && cubeB(1,end)==5) || (cubeA(1,end)==5 && cubeB(1,end)==4) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,2) == cubeB(1,2)) ) & ...
        ( (cubeA(1,3) == cubeB(1,3)+1) | (cubeA(1,3) == cubeB(1,3)-1) ) ) % yellow and magenta color can connect along z
    bConnected = true;
end


% if cubeA and cubeB are yellow and black
if ( (cubeA(1,end)==4 && cubeB(1,end)==6) || (cubeA(1,end)==6 && cubeB(1,end)==4) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % yellow and black color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are yellow and brown
if ( (cubeA(1,end)==3 && cubeB(1,end)==7) || (cubeA(1,end)==7 && cubeB(1,end)==3) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % yellow and brown color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==3 && cubeB(1,end)==7) || (cubeA(1,end)==7 && cubeB(1,end)==3) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,2) == cubeB(1,2)+1) | (cubeA(1,2) == cubeB(1,2)-1) ) ) % yellow and brown color can connect along y
    bConnected = true;
end

% if cubeA and cubeB are yellow and orange
if ( (cubeA(1,end)==4 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==4) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % yellow and orange color can connect along x
    bConnected = true;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if cubeA and cubeB are magenta and black
if ( (cubeA(1,end)==5 && cubeB(1,end)==6) || (cubeA(1,end)==6 && cubeB(1,end)==5) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % magenta and black color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are magenta and brown
if ( (cubeA(1,end)==5 && cubeB(1,end)==7) || (cubeA(1,end)==7 && cubeB(1,end)==5) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % magenta and brown color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are magenta and orange
if ( (cubeA(1,end)==5 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==5) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % magenta and orange color can connect along x
    bConnected = true;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if cubeA and cubeB are black and brown
if ( (cubeA(1,end)==6 && cubeB(1,end)==7) || (cubeA(1,end)==7 && cubeB(1,end)==6) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % black and brown color can connect along x
    bConnected = true;
end

% if cubeA and cubeB are black and orange
if ( (cubeA(1,end)==6 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==6) ) && ...  
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % black and orange color can connect along x
    bConnected = true;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if cubeA and cubeB are brown and orange
if ( (cubeA(1,end)==7 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==7) ) && ...
        any( ( (cubeA(1,2) == cubeB(1,2)) & (cubeA(1,3) == cubeB(1,3) ) ) & ...
        ( (cubeA(1,1) == cubeB(1,1)+1) | (cubeA(1,1) == cubeB(1,1)-1) ) )  % brown and orange color can connect along x
    bConnected = true;
elseif ( (cubeA(1,end)==7 && cubeB(1,end)==8) || (cubeA(1,end)==8 && cubeB(1,end)==7) ) && ...
        any( ( (cubeA(1,1) == cubeB(1,1)) & (cubeA(1,3) == cubeB(1,3)) ) & ...
        ( (cubeA(1,2) == cubeB(1,2)+1) | (cubeA(1,2) == cubeB(1,2)-1) ) ) % brown and orange color can connect along y
    bConnected = true;
end

end
