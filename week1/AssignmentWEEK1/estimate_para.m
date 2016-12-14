% mean [H S V]
mu = mean(Samples);

sig = cov([Samples(:,1),Samples(:,2) Samples(:,3)]);

save('mu.mat', 'mu');
save('sig.mat', 'sig');
