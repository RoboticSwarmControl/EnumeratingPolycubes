function numFinal = DrawWithAnyColor2D()
% Generates all valid colored polyominoes of size n tiles in 2D.
% A polyomino is a plane geometric figure formed by joining one or more equal tiles edge to edge. 
% https://en.wikipedia.org/wiki/Polyomino
% Uses algorithm from https://www.sciencedirect.com/science/article/pii/0012365X81902375?via%3Dihub
% We define red as 1 and blue as 0.
% Authors: Aaron T. Becker & Yitong Lu

% Rules:
% For Red:     Red and Red cannot connect y
% {S,N,0,N}    

% For Blue:    Blue and Blue cannot connect y
% {S,S,0,N}    Blue and Green cannot connect along y

% For Green:   Green and Green cannot connect along z and y
% {S,S,0,0}    Green and Blue cannot connect along y

% For Black:   
% {S,0,0,N}    

if nargin <1
    n = 3;
    nRed = 2;
    nBlue = 0;
    nGreen = 1;
    nBlack = 0;
end

% Initialization
polyList = zeros(n,1); %which tiles in adjTiles are used
adjTiles = zeros(4*n+2,2);
polyList(1) = 1;
adjTiles(1:3,:) = [0,0;
    0,1;
    1,0];  %do not number any square that is on a lower row, or left of the square on
% the same row. This is the version described by Redelmeier.
numTiles = 1;
% The simplest implementation involves adding one square at a time.
% Beginning with an initial square, number the adjacent squares, clockwise
% from the top, 1, 2, 3, and 4.
numAdj = 3;
colors = -1*ones(n,1);
numpolys = 0; %#ok<NASGU>

if nRed>0
    colors(1) = 1;  % set first tile was red
    [numpolysR,polysR] = recursPolyBuild(adjTiles, polyList, numTiles,numAdj,n, colors, nRed, nBlue, nGreen, nBlack);
else
    numpolysR = 0;
    polysR = [];
end
if nBlue>0
    colors(1) = 0;  % set first tile was blue
    [numpolysB,polysB] = recursPolyBuild(adjTiles, polyList, numTiles,numAdj,n, colors, nRed, nBlue, nGreen, nBlack);
else
    numpolysB = 0;
    polysB = [];
end
if nGreen>0
    colors(1) = 2;  % set first tile was green
    [numpolysG,polysG] = recursPolyBuild(adjTiles, polyList, numTiles,numAdj,n, colors, nRed, nBlue, nGreen, nBlack);
else
    numpolysG = 0;
    polysG = [];
end
if nBlack>0
    colors(1) = 3;  % set first tile was black
    [numpolysBL,polysBL] = recursPolyBuild(adjTiles, polyList, numTiles,numAdj,n, colors, nRed, nBlue, nGreen, nBlack);
else
    numpolysBL = 0;
    polysBL = [];
end

numpolys = numpolysR + numpolysB + numpolysG + numpolysBL;
polys = [polysR,polysB,polysG,polysBL];

% Check if the connection is correct or not
polyFinal = {};

for np = 1:numpolys
    if numpolys == 1
        polyFinal = polys;
        break
    end
    numcomp = ccMagneticPolyAll(polys{np});
    if numcomp == 1
        polyFinal(end+1) = polys(np); %#ok<AGROW>
    end
end


numFinal = numel(polyFinal);
disp(['With n=',num2str(n), ' cubes with ',num2str(nRed),' reds,', num2str(nBlue),' blues,', num2str(nGreen),' greens,', num2str(nBlack),' blacks,','there are ', num2str(numFinal),' colored polyominoes'])

figure(4);clf
ct = numel(polyFinal);
csqrt = ceil(sqrt(ct));
rectangle('Position',[-1,-1, (n+1)*csqrt+1, (n+1)*ceil(ct/csqrt)+1])
axis equal

for r = 1:csqrt
    for c = 1:csqrt
        iter = r + (c-1)*csqrt;
        if iter <= ct
            drawPolyomino(polyFinal{iter},(n+1)*(r-1),(n+1)*(c-1))
        end
    end
end


end

function [numpolys,polys] = recursPolyBuild(adjTiles, polyList, numTiles, numAdj,n, colors, nRed, nBlue, nGreen, nBlack)
numpolys = 0;
polys = {};
a = [0,0]; %#ok<NASGU>

if numTiles == n
    numpolys = 1; return;
end

if numTiles+1 == n
    % for each, see if it can be colored by the 1 remaining tile
    if sum(colors==0)<nBlue % if remain color is blue
        remColor = 0;
    end  
    if sum(colors==1)<nRed % if remain color is red
        remColor = 1;
    end 
    if sum(colors==2)<nGreen % if remain color is green
        remColor = 2;
    end
    if sum(colors==3)<nBlack % if remain color is black
        remColor = 3;
    end
    
    for i = polyList(numTiles)+1 : numAdj
        if remColor==0 && ~any(  (remColor == colors(1:numTiles)) & ... % Blue
                (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ... %same row
                (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ... % one column to left
                |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1) ... % one column to right
                )) && ...
                ~any(  (2 == colors(1:numTiles)) & ...
                (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ...
                (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ...
                |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1)) )  % blue and green cannot connect along y
            polysN = [adjTiles([polyList(1:numTiles);i],:), [colors(1:numTiles);remColor]];
            numpolys = numpolys+1;
            polys = [polys,polysN];   %#ok<AGROW>
            
        elseif remColor==1 && ~any(  (remColor == colors(1:numTiles)) & ... % red
                (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ... %same row
                (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ... % one column to left
                |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1) ... % one column to right
                ))
            polysN = [adjTiles([polyList(1:numTiles);i],:), [colors(1:numTiles);remColor]];
            numpolys = numpolys+1;
            polys = [polys,polysN];   %#ok<AGROW>
            
        elseif remColor==2 && ~any(  (remColor == colors(1:numTiles)) & ... % green
                (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ... %same row
                (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ... % one column to left
                |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1) ... % one column to right
                )) && ...
                ~any(  (0 == colors(1:numTiles)) & ...
                (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ...
                (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ...
                |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1)) )  % blue and green cannot connect along y
            polysN = [adjTiles([polyList(1:numTiles);i],:), [colors(1:numTiles);remColor]];
            numpolys = numpolys+1;
            polys = [polys,polysN];   %#ok<AGROW>
            
        elseif remColor==3  % Black
            polysN = [adjTiles([polyList(1:numTiles);i],:), [colors(1:numTiles);remColor]];
            numpolys = numpolys+1;
            polys = [polys,polysN];   %#ok<AGROW>
        end
    end
    
    return; % exit the recursion
end

% Now pick a number between polyList(numTiles)+1 and numAdj,
for i = polyList(numTiles)+1 : numAdj
    adjTilesi = adjTiles;
    polyListi = polyList;
    numAdji = numAdj;
    b = adjTiles(i,:);
    % add a square at that location.
    polyListi(numTiles+1) = i;
    
    % Number the unnumbered adjacent squares, starting with 5, remove ones already in adjList
    a = b + [0,1];
    if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2)) %~ismember(adjTiles, a,'rows') any is 73x faster than ismember
        numAdji = 1 + numAdji;
        adjTilesi(numAdji,:) = a;
    end
    a = b + [1,0];
    if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2))
        numAdji = 1 + numAdji;
        adjTilesi(numAdji,:) = a;
    end
    a = b + [0,-1];
    if a(2)>0 || (a(2)==0 && a(1)>0)  %don't add tiles below or to the left of starting tile @ (0,0)
        if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2))
            numAdji = 1 + numAdji;
            adjTilesi(numAdji,:) = a;
        end
    end
    a = b + [-1,0];
    if a(2)>0 || (a(2)==0 && a(1)>0)  %don't add tiles below or to the left of starting tile @ (0,0)
        if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2))
            numAdji = 1 + numAdji;
            adjTilesi(numAdji,:) = a;
        end
    end
    
    % can we color tile i red?
    if (sum(colors==1)< nRed) && ...
            ~any(  (1 == colors(1:numTiles)) & ...
            (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ... %same row
            (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ... % one column to left
            |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1) ... % one column to right
            ))
        colorsi = colors;
        colorsi(numTiles+1) = 1;
        [numpolysN,polysN] = recursPolyBuild(adjTilesi, polyListi, numTiles+1, numAdji, n, colorsi, nRed, nBlue, nGreen, nBlack);
        numpolys = numpolys + numpolysN;
        polys = [polys,polysN]; %#ok<AGROW>
    end
    
    % can we color tile i blue?
    if (sum(colors==0) < nBlue) && ...
            ~any( (0 == colors(1:numTiles)) & ...
            (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ... %same row
            (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ... % one column to left
            |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1) ... % one column to right
            )) && ...
            ~any(  (2 == colors(1:numTiles)) & ...
            (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ...
            (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ...
            |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1)) )  % blue and green cannot connect along y
        colorsi = colors;
        colorsi(numTiles+1) = 0;
        [numpolysN,polysN] = recursPolyBuild(adjTilesi, polyListi, numTiles+1, numAdji, n, colorsi, nRed, nBlue, nGreen, nBlack);
        numpolys = numpolys + numpolysN;
        polys = [polys,polysN]; %#ok<AGROW>
    end
    
    % can we color tile i green?
    if (sum(colors==2)< nGreen) && ...
            ~any( (2 == colors(1:numTiles)) & ...
            (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ... %same row
            (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ... % one column to left
            |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1) ... % one column to right
            )) && ...
            ~any(  (0 == colors(1:numTiles)) & ...
            (adjTiles(polyList(1:numTiles),1) == adjTiles(i,1)) & ...
            (   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)-1) ...
            |   (adjTiles(polyList(1:numTiles),2) == adjTiles(i,2)+1)) )  % blue and green cannot connect along y
        colorsi = colors;
        colorsi(numTiles+1) = 2;
        [numpolysN,polysN] = recursPolyBuild(adjTilesi, polyListi, numTiles+1, numAdji, n, colorsi, nRed, nBlue, nGreen, nBlack);
        numpolys = numpolys + numpolysN;
        polys = [polys,polysN]; %#ok<AGROW>
    end
    
    % can we color tile i black? 
    if (sum(colors==3) < nBlack) 
        colorsi = colors;
        colorsi(numTiles+1) = 3;
        [numpolysN,polysN] = recursPolyBuild(adjTilesi,polyListi,numTiles+1,numAdji, n, colorsi, nRed, nBlue, nGreen, nBlack);
        numpolys = numpolys + numpolysN;
        polys = [polys,polysN]; %#ok<AGROW>
    end
    % Then, pick a number larger than the previously picked number, and add that tile.  
    % Continue picking a number larger than the number of the current tile, adding that tile,
    % then numbering the new adjacent tiles. When n tiles have been created, an n-omino has been created.
end

end

function drawPolyomino(poly,x,y)
xv = [-.4, -.4, .1, .1,.45, .1, .1]; %arrow shape x
yv = [-.15, .15,.15,.4,.0,-.4,-.15]; %arrow shape y
ax = 0;
ay = 0;
for j = 1:size(poly,1)
    if poly(j,3) == 1
        fc = [1,0,0]; % red
    elseif poly(j,3) == 0
        fc = [0,0,1]; % blue
    elseif poly(j,3) == 2
        fc = [0,1,0]; % green
    elseif poly(j,3) == 3
        fc = [0,0,0]; % black
    end
    rectangle('Position',[x + poly(j,2)-ax+1, y+poly(j,1)-ay+1, 1,1],'FaceColor',fc);
    patch( double(x + poly(j,2))-ax+1+0.5+yv, double(y+poly(j,1))-ay+1+0.5+xv,'w');
end

end


