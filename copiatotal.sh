#!/bin/bash

mes=$(date +%B)
anio=$(date +%Y)
tar -czvf /bacyadey/copiatot-$mes-$anio.tar.gz /home
