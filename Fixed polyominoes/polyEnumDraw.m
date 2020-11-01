function numpolys = polyEnumDraw(n)
% Enumerate all the fixed polyominoes of size n tiles.
% A polyomino is a plane geometric figure formed by joining one or more
% equal squares edge to edge. It is a polyform whose cells are squares.
% https://en.wikipedia.org/wiki/Polyomino
% Uses algorithm from https://www.sciencedirect.com/science/article/pii/0012365X81902375?via%3Dihub
% Authors: Aaron T. Becker and Yitong Lu

if nargin <1
    n = 5;
end

polyList = zeros(n,1); % which tiles in adjTiles are used
adjTiles = zeros(4*n,2);

polyList(1) = 1; % set first tile was used

adjTiles(1:3,:) = [0,0;
    0,1;
    1,0];

numTiles = 1;

% The simplest implementation involves adding one square at a time.
% Beginning with an initial square, number the adjacent squares clockwise from the top, 1, 2, 3, and 4.
% Do not number any square that is on a lower row, or left of the square on the same row.
% This is the version described by Redelmeier.

numAdj = 3;
[numpolys,polys] = recursPolyBuild(adjTiles, polyList, numTiles,numAdj,n);
disp(['With n=',num2str(n), ' tiles there are ', num2str(numpolys),' fixed polyominoes'])

ct = numpolys;

figure(1);clf
csqrt = ceil(sqrt(ct));
rectangle('Position',[-1,-1, (n+1)*csqrt+1, (n+1)*ceil(ct/csqrt)+1])
axis equal

for r = 1:csqrt
    for c = 1:csqrt
        iter = r + (c-1)*csqrt;
        if iter <= ct
            poly = polys{iter};
            ax = mean(poly(:,1));
            ay = mean(poly(:,2));
            for j = 1:size(poly,1)
                fc = [1,1,1];
                rectangle('Position',[(n+1)*(r-1) + poly(j,1)-ax+1, (n+1)*(c-1)+poly(j,2)-ay+1, 1,1],'FaceColor',fc,'LineWidth',1.5)
            end
        end
    end
end
title(['With n=',num2str(n), ' tiles there are ', num2str(numpolys),' fixed polyominoes'])


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
            a = b + [0,1];
            if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2))
                numAdji = 1 + numAdji;
                adjTilesi(numAdji,:) = a;
            end
            a = b + [1,0];
            if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2))
                numAdji = 1 + numAdji;
                adjTilesi(numAdji,:) = a;
            end
            a = b + [0,-1];
            if a(2)>0 || (a(2)==0 && a(1)>0)  % don't add tiles below or to the left of starting tile @ (0,0)
                if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2))
                    numAdji = 1 + numAdji;
                    adjTilesi(numAdji,:) = a;
                end
            end
            a = b + [-1,0];
            if a(2)>0 || (a(2)==0 && a(1)>0)  % don't add tiles below or to the left of starting tile @ (0,0)
                if ~any(adjTiles(:,1)==a(1) & adjTiles(:,2)==a(2))
                    numAdji = 1 + numAdji;
                    adjTilesi(numAdji,:) = a;
                end
            end
            [numpolysN,polysN] = recursPolyBuild(adjTilesi, polyListi, numTiles+1, numAdji,n);
            numpolys = numpolys +numpolysN;
            polys = [polys,polysN]; %#ok<AGROW>
            
            % Then, pick a number larger than the previously picked number, and add that square.
            
            % Continue picking a number larger than the number of the
            % current square, adding that square, and then numbering the
            % new adjacent squares. When n squares have been created, an
            % n-omino has been created.
            
        end
        % This method ensures that each fixed polyomino is counted exactly n times,
        % once for each starting square. It can be optimized so that it counts each
        % polyomino only once, rather than n times. Starting with the initial
        % square, declare it to be the lower-left square of the polyomino. Simply
        % do not number any square that is on a lower row, or left of the square on
        % the same row. This is the version described by Redelmeier.
        
        % If one wishes to count free polyominoes instead, then one may check for
        % symmetries after creating each n-omino. However, it is faster to generate
        % symmetric polyominoes separately (by a variation of this method) and
        % so determine the number of free polyominoes by Burnside's lemma.
        
    end
end