#!/usr/bin/python

import sys
import time


def grant ():
      sys.stdout.write( 'OK\n' )
      sys.stdout.flush()


def deny ():
      sys.stdout.write( 'ERR\n' )
      sys.stdout.flush()


while True:
      line = sys.stdin.readline().strip()
      if line:
              grant()
      else:
              time.sleep( 1 )
