FasdUAS 1.101.10   ��   ��    k             j     �� �� 0 ptitle pTitle  m        � 	 	 > O p e n   F o l d i n g T e x t   f i l e   i n   M a r k e d   
  
 j    �� �� 0 pver pVer  m       �    0 . 0 2      j    �� �� 0 pauthor pAuthor  m       �    R o b i n   T r e w      l     ��������  ��  ��        l          j   	 �� �� *0 pblnpositionwindows pblnPositionWindows  m   	 
��
�� boovtrue  S M Set this to false to disable the window positioning at the end of the script     �   �   S e t   t h i s   t o   f a l s e   t o   d i s a b l e   t h e   w i n d o w   p o s i t i o n i n g   a t   t h e   e n d   o f   t h e   s c r i p t      l     ��������  ��  ��         i     ! " ! I     ������
�� .aevtoappnull  �   � ****��  ��   " k    d # #  $ % $ O     � & ' & k     ( (  ) * ) r     + , + 2   ��
�� 
docu , o      ���� 0 lstdocs lstDocs *  - . - Z    / 0���� / =     1 2 1 o    ���� 0 lstdocs lstDocs 2 J    ����   0 L    ����  ��  ��   .  3 4 3 r    : 5 6 5 n    + 7 8 7 J     + 9 9  : ; : 1   ! #��
�� 
pnam ;  <�� < m   % '��
�� 
file��   8 n      = > = 4     �� ?
�� 
cobj ? m    ����  > o    ���� 0 lstdocs lstDocs 6 J       @ @  A B A o      ���� 0 strname strName B  C�� C o      ���� 0 ofile oFile��   4  D E D I  ; @������
�� .miscactvnull��� ��� null��  ��   E  F�� F Z   A  G H���� G =  A D I J I o   A B���� 0 ofile oFile J m   B C��
�� 
msng H k   G { K K  L M L I  G x�� N O
�� .sysodlogaskr        TEXT N b   G T P Q P b   G R R S R b   G P T U T b   G N V W V b   G L X Y X b   G J Z [ Z m   G H \ \ � ] ]  T h e   d o c u m e n t :   [ o   H I��
�� 
ret  Y o   J K��
�� 
ret  W o   L M���� 0 strname strName U l 	 N O ^���� ^ o   N O��
�� 
ret ��  ��   S o   P Q��
�� 
ret  Q m   R S _ _ � ` ` ^ n e e d s   t o   b e   s a v e d   b e f o r e   M a r k e d   c a n   p r e v i e w   i t . O �� a b
�� 
btns a l 
 U Z c���� c J   U Z d d  e�� e m   U X f f � g g  O K��  ��  ��   b �� h i
�� 
dflt h m   ] ` j j � k k  O K i �� l��
�� 
appr l b   c r m n m b   c l o p o o   c h���� 0 ptitle pTitle p m   h k q q � r r      v e r .   n o   l q���� 0 pver pVer��   M  s�� s L   y {����  ��  ��  ��  ��   ' 5     �� t��
�� 
capp t m     u u � v v 6 c o m . f o l d i n g t e x t . F o l d i n g T e x t
�� kfrmID   %  w x w l  � ���������  ��  ��   x  y z y l  � ��� { |��   {  	-- Marked    | � } }  - -   M a r k e d z  ~  ~ O   � � � � � k   � � � �  � � � I  � �������
�� .miscactvnull��� ��� null��  ��   �  ��� � I  � ��� ���
�� .aevtodocnull  �    alis � o   � ����� 0 ofile oFile��  ��   � 5   � ��� ���
�� 
capp � m   � � � � � � � . c o m . b r e t t t e r p s t r a . m a r k y
�� kfrmID     � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � v p Try to position windows left and right (to disable this, if it doesn't suit your workflow or your screen setup,    � � � � �   T r y   t o   p o s i t i o n   w i n d o w s   l e f t   a n d   r i g h t   ( t o   d i s a b l e   t h i s ,   i f   i t   d o e s n ' t   s u i t   y o u r   w o r k f l o w   o r   y o u r   s c r e e n   s e t u p , �  � � � l  � ��� � ���   � B < set pblnPositionWindows at the top of the script to false )    � � � � x   s e t   p b l n P o s i t i o n W i n d o w s   a t   t h e   t o p   o f   t h e   s c r i p t   t o   f a l s e   ) �  ��� � Z   �d � ����� � o   � ����� *0 pblnpositionwindows pblnPositionWindows � k   �` � �  � � � r   � � � � � n   � � � � � 4   � ��� �
�� 
cwor � m   � �����  � l  � � ����� � I  � ��� ���
�� .sysoexecTEXT���     TEXT � m   � � � � � � � � d e f a u l t s   r e a d   / L i b r a r y / P r e f e r e n c e s / c o m . a p p l e . w i n d o w s e r v e r   |   g r e p   - w   W i d t h��  ��  ��   � o      ���� 0 lngwidth lngWidth �  � � � r   � � � � � n   � � � � � 4   � ��� �
�� 
cwor � m   � �����  � l  � � ����� � I  � ��� ���
�� .sysoexecTEXT���     TEXT � m   � � � � � � � � d e f a u l t s   r e a d   / L i b r a r y / P r e f e r e n c e s / c o m . a p p l e . w i n d o w s e r v e r   |   g r e p   - w   H e i g h t��  ��  ��   � o      ���� 0 	lngheight 	lngHeight �  � � � r   � � � � � ^   � � � � � o   � ����� 0 lngwidth lngWidth � m   � �����  � o      ���� 0 lnghalf lngHalf �  � � � r   � � � � � \   � � � � � o   � ����� 0 	lngheight 	lngHeight � m   � �����  � o      ���� 0 	lngheight 	lngHeight �  � � � l  � ���������  ��  ��   �  ��� � O   �` � � � k   �_ � �  � � � O  �! � � � O  �  � � � r   � � � � J   � � �  � � � J   � � � �  � � � o   � ����� 0 lnghalf lngHalf �  ��� � m   � ����� ��   �  ��� � J   � � �  � � � o   ����� 0 lnghalf lngHalf �  ��� � o  ���� 0 	lngheight 	lngHeight��  ��   � J       � �  � � � 1  ��
�� 
posn �  ��� � 1  ��
�� 
ptsz��   � 4   � ��� �
�� 
cwin � m   � �����  � 4   � ��� �
�� 
prcs � m   � � � � � � �  F o l d i n g T e x t �  ��� � O "_ � � � O -^ � � � r  6] � � � J  6F � �  � � � J  6< � �  � � � m  67����   �  ��� � m  7:���� ��   �  ��� � J  <D � �  � � � o  <?���� 0 lnghalf lngHalf �  ��� � o  ?B���� 0 	lngheight 	lngHeight��  ��   � J       � �  � � � 1  KP��
�� 
posn �  �� � 1  V[�~
�~ 
ptsz�   � 4  -3�} �
�} 
cwin � m  12�|�|  � 4  "*�{ �
�{ 
prcs � m  &) � � � � �  M a r k e d��   � 5   � ��z ��y
�z 
capp � m   � � � � � � �  s e v s
�y kfrmID  ��  ��  ��  ��      ��x � l     �w�v�u�w  �v  �u  �x       �t �   �s � � �r�q�p�o�n�m�l�k�j�i�t   � �h�g�f�e�d�c�b�a�`�_�^�]�\�[�Z�Y�X�W�V�U�h 0 ptitle pTitle�g 0 pver pVer�f 0 pauthor pAuthor�e *0 pblnpositionwindows pblnPositionWindows
�d .aevtoappnull  �   � ****�c 0 lstdocs lstDocs�b 0 strname strName�a 0 ofile oFile�` 0 lngwidth lngWidth�_ 0 	lngheight 	lngHeight�^ 0 lnghalf lngHalf�]  �\  �[  �Z  �Y  �X  �W  �V  �U  
�s boovtrue � �T "�S�R�Q
�T .aevtoappnull  �   � ****�S  �R     (�P u�O�N�M�L�K�J�I�H�G�F \�E _�D f�C j�B q�A�@ ��? ��>�=�< ��;�:�9 ��8 ��7�6�5 �
�P 
capp
�O kfrmID  
�N 
docu�M 0 lstdocs lstDocs
�L 
cobj
�K 
pnam
�J 
file�I 0 strname strName�H 0 ofile oFile
�G .miscactvnull��� ��� null
�F 
msng
�E 
ret 
�D 
btns
�C 
dflt
�B 
appr�A 
�@ .sysodlogaskr        TEXT
�? .aevtodocnull  �    alis
�> .sysoexecTEXT���     TEXT
�= 
cwor�< 0 lngwidth lngWidth�; 0 	lngheight 	lngHeight�: 0 lnghalf lngHalf�9 
�8 
prcs
�7 
cwin
�6 
posn
�5 
ptsz�Qe)���0 y*�-E�O�jv  hY hO��k/[�,\[�,\ZlvE[�k/E�Z[�l/E�ZO*j 
O��  9��%�%�%�%�%�%�a kva a a b   a %b  %a  OhY hUO)�a �0 *j 
O�j UOb   �a j a m/E` Oa j a m/E` O_ l!E` O_ a  E` O)�a !�0 *a "a #/ 5*a $k/ +_ a  lv_ _ lvlvE[�k/*a %,FZ[�l/*a &,FZUUO*a "a '/ 3*a $k/ )ja  lv_ _ lvlvE[�k/*a %,FZ[�l/*a &,FZUUUY h � �4�4    		 
�3
�                                                                                      @ alis    `  Macintosh HD               �9�SH+  P0FoldingText.app                                                j�Z�E�        ����  	                Applications    �9�S      �E�    P0  *Macintosh HD:Applications: FoldingText.app     F o l d i n g T e x t . a p p    M a c i n t o s h   H D  Applications/FoldingText.app  / ��  
�3 
docu � ( n o t e s - 2 0 1 4 - 0 3 - 1 3 . t x t  
�2
�2 
docu � ( n o t e s - 2 0 1 4 - 0 3 - 1 0 . t x t  � ( n o t e s - 2 0 1 4 - 0 3 - 1 3 . t x t dfurlfile:///Users/robintrew/Library/Application%20Support/Notational%20Velocity/notes-2014-03-13.txt �  2 5 6 0�r* @�      �q  �p  �o  �n  �m  �l  �k  �j  �i   ascr  ��ޭ