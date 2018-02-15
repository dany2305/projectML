function ret = shuffle(mat) %shuffle row

[r c] = size(mat);
shuffledRow = randperm(r);
ret = mat(shuffledRow, :);
end