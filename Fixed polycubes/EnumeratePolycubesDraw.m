function numpolys = EnumeratePolycubesDraw(n)
% Enumerate all the fixed polycubes of size n tiles.
% fix the origin at the leftmost cube
% Only add cubes when:
% {(x, y, z) | (z > 0) or ((z = 0) and (y > 0)) or ((z = 0) and (y = 0) and x > 0)}.
% Aaron T. Becker & Yitong Lu

if nargin <1
    n = 3;
end

polyList = zeros(n,1); % which tiles in adjTiles are used
adjTiles = zeros(4*n+2,3);

polyList(1) = 1; % set first tile was used

adjTiles(1:4,:) = [0,0,0;
    0,0,1;
    0,1,0;
    1,0,0];

numTiles = 1;

numAdj = 4;

[numpolys,polys] = recursPolyBuild(adjTiles, polyList, numTiles,numAdj,n);
disp(['With n=',num2str(n), ' tiles there are ', num2str(numpolys),' fixed polycubes'])

c = ceil(sqrt(numpolys));
r = c;
for i = 1:numpolys
    subplot(r,c,i)
    for ep = 1:n
        DisplayWorkspace3D(polys{i}(ep,:),1,1,1,'w');     
    end
    axis tight
    set(gca,'xtick','','ytick','','ztick','','Visible','off')
end

filename = ['With n=',num2str(n) 'Fixed Polycubes'];
fig1=figure(1);
fig1.Renderer='Painters';

print(filename,'-dpdf','-bestfit')

end


function [numpolys,polys] = recursPolyBuild(adjTiles, polyList, numTiles, numAdj,n)
numpolys = 0;
polys ={};
if numTiles+1 == n
    numpolys = numAdj-polyList(numTiles);
    for i = polyList(numTiles)+1 : numAdj
        polys{end+1} = adjTiles([polyList(1:n-1);i],:); %#ok<AGROW>
    end
    return;
end

% pick a number between polyList(numTiles)+1 and numAdj,
for i = polyList(numTiles)+1 : numAdj
    adjTilesi = adjTiles;
    polyListi = polyList;
    numAdji = numAdj;
    b = adjTiles(i,:);
    % add a square at that location.
    polyListi(numTiles+1) = i;
    
    % Number the unnumbered adjacent squares, starting with 5, remove ones already in adjList
    a = b + [0,1,0];
    if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2) & adjTiles(:,3)==a(3))
        numAdji = 1 + numAdji;
        adjTilesi(numAdji,:) = a;
    end
    a = b + [1,0,0];
    if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2) & adjTiles(:,3)==a(3))
        numAdji = 1 + numAdji;
        adjTilesi(numAdji,:) = a;
    end
    a = b + [0,0,1];
    if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2) & adjTiles(:,3)==a(3))
        numAdji = 1 + numAdji;
        adjTilesi(numAdji,:) = a;
    end

    a = b + [0,-1,0];
    % (z > 0) or ((z = 0) and (y > 0)) or ((z = 0) and (y = 0) and x > 0)}.
    if a(3)>0 || (a(3)==0 && a(2)>0) || (a(3)==0 && a(2)==0 && a(1)>0) 
        if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2) & adjTiles(:,3)==a(3))
            numAdji = 1 + numAdji;
            adjTilesi(numAdji,:) = a;
        end
    end
    a = b + [-1,0,0];
    if a(3)>0 || (a(3)==0 && a(2)>0) || (a(3)==0 && a(2)==0 && a(1)>0)
        if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2) & adjTiles(:,3)==a(3))
            numAdji = 1 + numAdji;
            adjTilesi(numAdji,:) = a;
        end
    end
    a = b + [0,0,-1];
    if a(3)>0 || (a(3)==0 && a(2)>0) || (a(3)==0 && a(2)==0 && a(1)>0)
        if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2) & adjTiles(:,3)==a(3))
            numAdji = 1 + numAdji;
            adjTilesi(numAdji,:) = a;
        end
    end
    
    [numpolysN,polysN] = recursPolyBuild(adjTilesi, polyListi, numTiles+1, numAdji,n);
    numpolys = numpolys +numpolysN;
    polys = [polys,polysN]; %#ok<AGROW>
    
end

end

function DisplayWorkspace3D(origin,X,Y,Z,color)
% origin = origin point for the cube in the form of [x,y,z].
% X      = cube length along x direction.
% Y      = cube length along y direction.
% Z      = cube length along z direction.

% List of colors
% b: blue
% r: red
% k: black
% w: white

% Define the vertexes of the unit cubic
ver = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1];

% Define the faces of the unit cubic
fac = [1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 1 2 3 4; 5 6 7 8];

cube = [ver(:,1)*X+origin(1),ver(:,2)*Y+origin(2),ver(:,3)*Z+origin(3)];
patch('Faces',fac,'Vertices',cube,'FaceColor',color);

% Set the axis with equal unit.
axis equal
axis tight
% axis([-3,3,-3,3,-3,3])

% Set the view point
view(40,20);

end

