# Leitura de um arquivo de audio .wav

clear all;                              # Remove variaveis do ambiente
close all;                              # Fecha janelas graficas abertas
clc                                     # Limpa janela de comandos
fs = 44100;                             # Frequencia de amostragem, Hz
resp = 0 ;                              # Nome do arquivo a ser carregado
n = 0;                                  # Tamanho do arquivo aberto

while (resp!=9)
  printf("\n\n-----------------------------------------------\n")
  printf("             Selecione uma opcao:\n")
  printf("-----------------------------------------------\n\n")
  printf(" 1 - Ler um arquivo de audio .wav\n\n")
  printf(" 2 - Gravar um arquivo de audio .wav\n\n")
  printf(" 3 - Reproduzir audio .wav\n\n")
  printf(" 4 - Grafico do sinal amostrado\n\n")
  printf(" 5 - Detalhes do grafico do sinal\n\n")
  printf(" 6 - Grafico da transformada de Fourier\n\n")
  printf(" 7 - Grafico da magnitude da transformada\n\n")
  printf(" 8 - Grafico da magnitude da transformada (dB)\n\n")
  printf(" 9 - Sair\n\n")
  printf("-----------------------------------------------\n")
  resp =(input("Opcao: "));
  printf("-----------------------------------------------\n")
  switch resp
    case 1                                # Le um arquivo de audio .wav
      nome_arquivo = input("\nNome do arquivo (*.wav): ", "s");
      [sinal, fs] = audioread([nome_arquivo,".wav"]);
      sinal_tff = fft(sinal);           # Transformada de Fourier do sinal_tff
      sinal_magnitude = abs(sinal_tff); # Magnitude da transformada
      sinal_db = mag2db(sinal_magnitude);
      n = length(sinal);                  # Tamanho dos dados lidos e duracao do audio
      printf(["\nQuantidade de valores amostrados: ", num2str(n), " valores"])
      printf(["\n\nDuracao do audio: ", num2str(n/fs)," segundos"])
      printf("\n\nNivel maximo de sinal: %d dB\n", mean(max(sinal_db)))
    case 2
      bits = 16;                          # Numero de bits/amostra
      canais = 1;                         # Numero de canais
      r = audiorecorder(fs, nbits, nchans)
      disp('Comece a falar...')
      record(r);
      pause(5); % 5 segundos de gravacao
      stop(r);
      som = getaudiodata(r, 'double');
      audiowrite('amostra.wav', som, fs); 
      soundsc(falad, fs); % ou p = play(r);
    case 3
      if (n!=0)                           # Se 0 indica nenhum arquivo carregado
        sound(sinal, fs);                 # Reproducao no alto-falante
      else
        printf("\nSem arquivo de audio carregado!")
      endif
    case 4
      if (n!=0)                           # Se 0 indica nenhum arquivo carregado
        figure;                           # Abre nova janela grafica
        plot(sinal);                      # Plota o sinal lido
        axis tight;
        title('Sinal Amostrado (Amostragem = 44100 Hz)');
        xlabel("Amostras");
        ylabel("Amplitude");
        grid minor;
       else
        printf("\nSem arquivo de audio carregado!")
      endif
    case 5
      if (n!=0)                           # Se 0 indica nenhum arquivo carregado 
        ini_intervalo = input("\nInicio do intervalo: ");
        fim_intervalo = input("\nFim do intervalo: ");
        intervalo = ini_intervalo:fim_intervalo;  # Intervalo que sera amostrado
        figure;
        plot(intervalo, sinal(intervalo));
        axis tight; 
        title('Detalhes de um intervalo do sinal amostrado (amostragem = 44100 Hz)');
        grid minor;
        xlabel("Amostras");
        ylabel("Amplitude");
       else
        printf("\nSem arquivo de audio carregado!")
      endif
    case 6
      if (n!=0)                           # Se 0 indica nenhum arquivo carregado
        figure;                           # Nova janela grafica
        plot(sinal_tff);               
        axis tight; 
        title('Transformada de Fourier do Sinal');
        grid minor;
       else
        printf("\nSem arquivo de audio carregado!")
       endif
     case 7
       if (n!=0)                           # Se 0 indica nenhum arquivo carregado
         f = (0:n-1)/n*fs;                 # Eixo da transformada em Hz
         intervalo = 1:floor(n/4.41);      # Amostragem 44100Hz
         figure;
         semilogx(f(intervalo), sinal_magnitude(intervalo)/n),           
         axis tight;
         grid minor;
         title('Magnitude da Transformada de Fourier');
         xlabel('log f [Hz]');
         ylabel('Amplitude');
       else
         printf("\nSem arquivo de audio carregado!")
       endif
       case 8
       if (n!=0)                           # Se 0 indica nenhum arquivo carregado
         f = (0:n-1)/n*fs;                 # Eixo da transformada em Hz
         intervalo = 1:floor(n/2.205);     # Amostragem 44100Hz
         figure;
         semilogx(f(intervalo), sinal_db(intervalo)),           
         axis tight;
         grid minor;
         title('Magnitude da Transformada de Fourier (dB)');
         xlabel('log f [Hz]');
         ylabel('Amplitude');
       else
         printf("\nSem arquivo de audio carregado!")
       endif
  endswitch
 endwhile