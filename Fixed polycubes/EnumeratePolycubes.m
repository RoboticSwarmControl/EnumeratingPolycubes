function numpolys = EnumeratePolycubes(n)
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
    0,1,0;
    1,0,0;
    0,0,1;];

numTiles = 1;

numAdj = 4;
numpolys = recursPolyBuild(adjTiles, polyList, numTiles, numAdj, n);
disp(['With n=',num2str(n), ' tiles there are ', num2str(numpolys),' fixed polycubes'])
end

function numpolys = recursPolyBuild(adjTiles, polyList, numTiles, numAdj, n)
numpolys = 0;

if numTiles+1 == n
    numpolys = numAdj-polyList(numTiles); 
    return;
end

% pick a number between polyList(numTiles)+1 and numAdj
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
    
    numpolys = numpolys + recursPolyBuild(adjTilesi, polyListi, numTiles+1, numAdji, n);
    
end

end
