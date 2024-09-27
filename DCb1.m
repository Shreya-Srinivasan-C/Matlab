% Define generator polynomials
g1 = [1 1 1]; % Generator polynomial g1 (binary: 111)
g2 = [1 1 1]; % Generator polynomial g2 (binary: 111)

% Create the trellis structure
trellis = poly2trellis(3, [7 7]); % For g1 = 111, g2 = 111 in octal form

% Define binary input data
input_data = [1  1  0  0  0  0  0  0  1  1  0  0  1  0  0  1  1  0  1  0  0  1  1  1  1 ]; % Given input data

% Convolutionally encode the input data
encoded_data = convenc(input_data, trellis);

% Display the encoded data
disp('Encoded Data:');
disp(encoded_data);

%% State Table Development
disp('State Table:');
states = {'00', '01', '10', '11'};
input_bits = [0 1];
next_states = cell(4, 2);
outputs = cell(4, 2);

for s = 1:length(states)
    for i = 1:length(input_bits)
        current_state = states{s};
        input_bit = input_bits(i);
        
        % Next state calculation
        next_state = [num2str(input_bit) current_state(1:2)];
        next_state = next_state(1:2);
        next_states{s, i} = next_state;
        
        % Output calculation
        output1 = mod(input_bit + str2double(current_state(1)) + str2double(current_state(2)), 2);
        output2 = mod(input_bit + str2double(current_state(1)) + str2double(current_state(2)), 2);
        outputs{s, i} = [output1 output2];
        
        % Display state table row
        fprintf('Current State: %s, Input: %d, Next State: %s, Output: [%d %d]\n', ...
            current_state, input_bit, next_state, output1, output2);
    end
end

%% Trellis Diagram for Encoding
figure;
hold on;
title('Trellis Diagram for Encoding');
xlabel('Time Step');
ylabel('States');
set(gca, 'YTick', 1:length(states), 'YTickLabel', states);

% Plot states at each time step
time_steps = 0:length(input_data);
num_states = length(states);
for t = 1:length(time_steps)
    for s = 1:num_states
        plot(t, s, 'bo', 'MarkerFaceColor', 'b');
        text(t, s, states{s}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end
end

% Plot state transitions for the actual data path
current_state_idx = 1; % Initial state is '00'
for t = 1:length(input_data)
    input_bit = input_data(t);
    next_state_idx = find(strcmp(states, next_states{current_state_idx, input_bit + 1}));
    
    % Plot the transition
    x = [t-1 t];
    y = [current_state_idx next_state_idx];
    plot(x, y, 'r-', 'LineWidth', 2); % Use a thicker red line for the actual data path
    quiver(t-1, current_state_idx, 1, next_state_idx - current_state_idx, 0, 'MaxHeadSize', 0.5, 'Color', 'r', 'LineWidth', 2);
    
    % Move to the next state
    current_state_idx = next_state_idx;
end

hold off;




%% Viterbi Decoding
% Decode the received data using Viterbi algorithm
decoded_data = vitdec(encoded_data, trellis, 5, 'trunc', 'hard');

% Display the decoded data
disp('Decoded Data:');
disp(decoded_data);

% Check if the decoded data matches the input data
if isequal(input_data, decoded_data)
    disp('Decoded data matches the original input data.');
else
    disp('Decoded data does NOT match the original input data.');
end

%% Trellis Diagram for Decoding
figure;
hold on;
title('Trellis Diagram for Decoding');
xlabel('Time Step');
ylabel('States');
set(gca, 'YTick', 1:length(states), 'YTickLabel', states);

% Plot states at each time step
for t = 1:length(time_steps)
    for s = 1:num_states
        plot(t, s, 'bo', 'MarkerFaceColor', 'b');
        text(t, s, states{s}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end
end

% Plot state transitions for the actual decoded path
current_state_idx = 1; % Initial state is '00'
for t = 1:length(decoded_data)
    input_bit = decoded_data(t);
    next_state_idx = find(strcmp(states, next_states{current_state_idx, input_bit + 1}));
    
    % Plot the transition
    x = [t-1 t];
    y = [current_state_idx next_state_idx];
    plot(x, y, 'g-', 'LineWidth', 2); % Use a thicker green line for the actual decoded data path
    quiver(t-1, current_state_idx, 1, next_state_idx - current_state_idx, 0, 'MaxHeadSize', 0.5, 'Color', 'g', 'LineWidth', 2);
    
    % Move to the next state
    current_state_idx = next_state_idx;
end



