DROP TABLE IF EXISTS yasui_user CASCADE;
DROP TABLE IF EXISTS item CASCADE;
DROP TABLE IF EXISTS stock CASCADE;
DROP TABLE IF EXISTS contents CASCADE;
DROP TABLE IF EXISTS orders CASCADE;

commit;

CREATE TABLE yasui_user(
	user_id NCHAR(5)  NOT NULL,
	name NVARCHAR(20) NOT NULL,
	passwd NVARCHAR(42) NOT NULL,
	descript NVARCHAR(42) NOT NULL,
	role NVARCHAR(30)  NOT NULL,
	is_delete INT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY( user_id ),
	UNIQUE KEY uq_data1 ( name )
);

CREATE TABLE item(
	item_id NCHAR(5) NOT NULL ,
	item_name NVARCHAR(50) NOT NULL,
	imgurl NVARCHAR(50) DEFAULT NULL,
	item_size NVARCHAR(50) DEFAULT NULL,
	price INT(8) NOT NULL,
	is_delete INT(1)  NOT NULL DEFAULT 0,
	PRIMARY KEY( item_id )
);

CREATE TABLE stock(
	item_id NCHAR(5) NOT NULL,
	stock_num INT(8) NOT NULL,
	is_delete INT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY( item_id )
);

CREATE TABLE contents (
  mid NVARCHAR(20) NOT NULL,
  title NVARCHAR(100) DEFAULT NULL,
  keywd NVARCHAR(50) DEFAULT NULL,
  descript NVARCHAR(100) DEFAULT NULL,
  role NVARCHAR(100) DEFAULT NULL,
  skip INT(1) DEFAULT 0,
  PRIMARY KEY(mid)
);

CREATE TABLE orders  (
  oid NVARCHAR(25) NOT NULL,
  item_id NCHAR(5) NOT NULL,
  user_name NVARCHAR(20) NOT NULL,
  quantity INT(8) DEFAULT NULL,
  is_delivery INT(1) NOT NULL DEFAULT 0,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  delivery_date TIMESTAMP DEFAULT 0,
  PRIMARY KEY(oid,item_id)
);

commit;

INSERT INTO yasui_user VALUES ('A0001','admin','password',n'�Ǘ���','administrator',0);
INSERT INTO yasui_user VALUES ('C0001','customer1','password',n'����^�i','user',0);
INSERT INTO yasui_user VALUES ('C0002','customer2','password',n'�{�c�\�C','user',0);

INSERT INTO item VALUES ('00001',n'�L�b�`���e�[�u���i���j','http://localhost:8080/yasui/img/00001.jpg','100x60x70',19800,0);
INSERT INTO item VALUES ('00002',n'�f�X�N�i�u���E���j','http://localhost:8080/yasui/img/00002.jpg','100x60x70',123500,0);
INSERT INTO item VALUES ('00003',n'�����i�j','http://localhost:8080/yasui/img/00003.jpg','100x60x70',9800,0);
INSERT INTO item VALUES ('00004',n'�x�b�h','http://localhost:8080/yasui/img/00004.jpg','100x60x70',354800,0);
INSERT INTO item VALUES ('00005',n'�\�t�@�[','http://localhost:8080/yasui/img/00005.jpg','100x60x70',99999,0);

INSERT INTO stock VALUES ('00001',25,0);
INSERT INTO stock VALUES ('00002',25,0);
INSERT INTO stock VALUES ('00003',25,0);
INSERT INTO stock VALUES ('00004',25,0);
INSERT INTO stock VALUES ('00005',0,0);

INSERT INTO contents VALUES ('Login','P0001:���O�C��','���O�C��','���O�C���������s���܂��B','user',1);
INSERT INTO contents VALUES ('LoginError','���O�C���G���[','���O�C��, �G���[','���O�C���G���[��ʂł��B','user',1);
INSERT INTO contents VALUES ('ListItem','P0002:���i�ꗗ','���i�ꗗ, ���C��, �g�b�v','�ʐM�̔��V�X�e���̃��C�����j���[�ł��B','user',0);
INSERT INTO contents VALUES ('PurchaseConfirm','P0003:�����̊m�F','�Ƌ�,����,�m�F','�����̊m�F���s���܂�','user',0);
INSERT INTO contents VALUES ('PurchaseStoreDb','P0004:�����̊���','�Ƌ�,����','�������������܂�','user',0);
INSERT INTO contents VALUES ('PurchaseComplete','P0004:�����̊���','�Ƌ�,����','�������������܂�','user',0);
INSERT INTO contents VALUES ('Logout','P0005:���O�A�E�g','���O�A�E�g','�ʐM�̔��V�X�e������̃��O�A�E�g�������s���܂��B','user',0);
INSERT INTO contents VALUES ('AddItem','A0001:�V�K���i�o�^','�V�K, ���i, �o�^','�V�K���i�o�^���s���܂��B','administrator',0);
INSERT INTO contents VALUES ('AddItemConfirm','A0002:�V�K���i�o�^�̊m�F','�V�K, ���i, �o�^','�V�K���i�o�^�̊m�F���s���܂�','administrator',0);
INSERT INTO contents VALUES ('AddItemStoreDb','A0003:�V�K���i�o�^�̊���','�V�K, ���i, �o�^','�V�K���i�o�^���������܂�','administrator',0);
INSERT INTO contents VALUES ('AddItemComplete','A0003:�V�K���i�o�^�̊���','�V�K, ���i, �o�^','�V�K���i�o�^���������܂�','administrator',0);
INSERT INTO contents VALUES ('ChangeStock','A0004:�݌ɐ��ʕύX','�݌�,����,�ύX ���i, �o�^','�݌ɐ��ʂ̕ύX���s���܂��B','administrator',0);
INSERT INTO contents VALUES ('ChangeStockConfirm','A0005:�݌ɐ��ʕύX�̊m�F','�݌�,����,�ύX ���i, �o�^','�݌ɐ��ʕύX�̊m�F���s���܂�','administrator',0);
INSERT INTO contents VALUES ('ChangeStockStoreDb','A0006:�݌ɐ��ʕύX�̊���','�݌�,����,�ύX ���i, �o�^','�݌ɐ��ʕύX���������܂�','administrator',0);
INSERT INTO contents VALUES ('ChangeStockComplete','A0006:�݌ɐ��ʕύX�̊���','�݌�,����,�ύX ���i, �o�^','�݌ɐ��ʕύX���������܂�','administrator',0);
INSERT INTO contents VALUES ('RemoveItem','A0007:���i�폜','���i, �폜','���i�̍폜���s���܂��B','administrator',0);
INSERT INTO contents VALUES ('RemoveItemConfirm','A0008:���i�폜�̊m�F','���i, �폜','���i�폜�̊m�F���s���܂�','administrator',0);
INSERT INTO contents VALUES ('RemoveItemComplete','A0009:���i�폜�̊���','���i, �폜','���i�폜���������܂�','administrator',0);
INSERT INTO contents VALUES ('RemoveItemStoreDb','A0009:���i�폜�̊���','���i, �폜','���i�폜���������܂�','administrator',0);

commit;