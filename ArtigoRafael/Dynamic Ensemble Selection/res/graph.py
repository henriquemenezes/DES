import numpy as np
import argparse
import re

parser = argparse.ArgumentParser(description='Gera grafico, comparativo')
parser.add_argument('arquivo')
args = parser.parse_args()

arq = open(args.arquivo, 'r')
data = arq.read().split('\n')
total_lines = len(data)

saida = open(args.arquivo + '.csv', 'w')

for i in range(total_lines/4):
    base = re.search('database: \[(\w+)\]', data[i * 4]).group(1)

    print base
    saida.write(base + ';')
    
    knorae_acc = []
    knorae_time = []
    ola_acc = []
    ola_time = []
    lca_acc = []
    lca_time = []
    
    for j in range(3):
        reknorae = re.search('KNORAE\((\d+?\.?\d+?),(\d+?\.?\d+?)\)', data[j + 1 + (i*4)])
        knorae_acc.append(float(reknorae.group(1)))
        knorae_time.append(float(reknorae.group(2)))

        reola = re.search('OLA\((\d+?\.?\d+?),(\d+?\.?\d+?)\)', data[j + 1 + (i*4)])
        ola_acc.append(float(reola.group(1)))
        ola_time.append(float(reola.group(2)))

        relca = re.search('LCA\((\d+?\.?\d+?),(\d+?\.?\d+?)\)', data[j + 1 + (i*4)])
        lca_acc.append(float(relca.group(1)))
        lca_time.append(float(relca.group(2)))

    print 'knorae ', np.mean(knorae_acc)
    print 'ola ', np.mean(ola_acc)
    print 'lca ', np.mean(lca_acc)
    print ''
    
    saida.write(('%.2f' % np.mean(knorae_acc)) + ';')
    saida.write(('%.2f' % np.mean(ola_acc)) + ';')
    saida.write(('%.2f' % np.mean(lca_acc)) + '\n')

arq.close()
saida.close()
