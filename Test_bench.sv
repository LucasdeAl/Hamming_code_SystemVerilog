module test_hamming_code;

    logic [7:0] test_data;
    logic [11:0] encoded_data;
    logic [3:0] parity_bits;
    logic [7:0] decoded_data;
    logic [3:0] verify_bit;
    logic [11:0] encoded_data_error;
  

    // Instancie o módulo de codificação de Hamming
    hamming_code encoder (
        .data_in(test_data),
        .encoded_data(encoded_data),
      .parity_bits(parity_bits)
    );

    // Instancie o módulo de decodificação de Hamming
    hamming_decode decoder (
        .encoded_data(encoded_data_error),
        .decoded_data(decoded_data),
        .verify_bit(verify_bit)
    );

    initial begin
		
        // Teste 1: Dados sem erro
        test_data = 8'b10101010; // Dados de entrada
        #10 // Aguarde alguns ciclos de clock
      
      $display("Dado de entrada = %bEncoded_data = %b",test_data,encoded_data);
         // Verifique se os dados decodificados correspondem aos dados de entrada
      for(int i=0;i<12;i++)
        begin
          encoded_data_error = encoded_data ^(1<<i);
          #10
          
          $display("Aplicando erro no bit %d,  = %b",i,encoded_data_error);
          if (decoded_data == test_data)
            begin
            	$display("saida = %b, sem erros\n",decoded_data);
              $display("parity bits = %b\n",verify_bit);
            end
            else begin
            	$display("saida = %b, com erros\n",decoded_data);
            	$display("parity bits = %b\n",verify_bit);
        	end
        end
      
      
      $display("Encoded_data_error = %b",encoded_data_error);
      
		$finish;
    end

endmodule


