Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37391294621
	for <lists+linux-block@lfdr.de>; Wed, 21 Oct 2020 03:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439809AbgJUBIj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Oct 2020 21:08:39 -0400
Received: from m12-11.163.com ([220.181.12.11]:59849 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439808AbgJUBIi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 21:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Mime-Version:Subject:Message-Id:Date; bh=blTLE
        MiHzIL3A+oToMsg9lvnMBLyuw65GXBez9yjqCw=; b=UOlcytxRzR759QGvXwH48
        /NSOL1mSitohhFxMFH1han69l2TriGDtBavSCjJJ1zpNQ44BQjs3h+EocqxgjvG0
        EQnptR+BhY+6+dPSxc66dlM6BpV1hT3A3B0rJZL1n3llsPMXIv0cq13e9pbrFEBg
        UjoAEEM6aE6zHhN/UQLJBA=
Received: from [172.20.146.138] (unknown [223.112.105.132])
        by smtp7 (Coremail) with SMTP id C8CowAB3A9n7iY9fs8L2EA--.2741S3;
        Wed, 21 Oct 2020 09:08:11 +0800 (CST)
From:   lining <lining2020x@163.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [bug report] NBD: rbd-nbd + ext4 stuck after nbd resized 
Message-Id: <AA00244F-0E5A-4E52-B358-4F36A3486EBF@163.com>
Date:   Wed, 21 Oct 2020 09:08:10 +0800
Cc:     lining <lining2020x@163.com>, donglifekernel@126.com
To:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, yunchuan.wen@kylin-cloud.com,
        ceph-users@ceph.io
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-CM-TRANSID: C8CowAB3A9n7iY9fs8L2EA--.2741S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1UWrWUKr18Gw1UXr13Jwb_yoW5CrWfpF
        srK3W5GF1v9w1UWF4xWF1UXFyF9an2y3WUW392gr1jvrZFqrn7t3WIka42gF4UK39rWws7
        WF95twn7Wr1UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UeHqcUUUUU=
X-Originating-IP: [223.112.105.132]
X-CM-SenderInfo: polqx0bjsqjir06rljoofrz/1tbisBnENlUMPvS7dQAAsG
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Sorry for sending this mail again, this one add nbd@other.debian.org)

Hi kernel=E3=80=81ceph comunity:

We run into an issue that mainly related to the (kernel) nbd driver and =
(ceph) rbd-nbd.=20
After some investigations, I found that the root cause of the problem =
seems to be related to the change in the block size of nbd.

I am not sure whether it is the nbd driver or rbd-nbd bug, however there =
is such a problem.


What happened=EF=BC=9A
It will always hang when accessing the mount point of nbd device with =
ext4 after nbd resized.=20


Environment information:
- kernel:               v4.19.25 or master
- rbd-nbd(ceph):  v12.2.0 Luminous or master
- the fs of nbd:    ext4


Steps to reproduce:
1. rbd create --size 2G rbdpool/foo  # create a 2G size rbd image
2. rbd-nbd map rbdpool/foo            # map the rbd image as a local =
block device /dev/nbd0, block size is 512(the default block size is set =
in rbd-nbd code when nbd mapped).
3. mkfs.ext4 /dev/nbd0                     # mkfs.ext4 on nbd0, only nbd =
+ ext4 can reproduce the problem
4. mount /dev/nbd0 /mnt                # mount nbd0 on /mnt
5. rbd resize --size 4G rbdpool/foo   # expand the nbd backend image =
from 2G to 4G size
6. ls /mnt                                         # `ls` stuck here =
forever

ln@ubuntu:linux>$ ps -ef |grep mnt
root        8670    7519 98 10:16 pts/5    00:28:46 ls --color=3Dauto =
/mnt/
ln          9508    9293  0 10:45 pts/6    00:00:00 grep --color=3Dauto =
mnt


ln@ubuntu:linux>$ sudo cat /proc/8670/stack
[<0>] io_schedule+0x1a/0x40
[<0>] __lock_page+0x105/0x150
[<0>] pagecache_get_page+0x199/0x2c0
[<0>] __getblk_gfp+0xef/0x290
[<0>] ext4_getblk+0x83/0x1a0
[<0>] ext4_bread+0x26/0xb0
[<0>] __ext4_read_dirblock+0x34/0x2c0
[<0>] htree_dirblock_to_tree+0x56/0x1c0
[<0>] ext4_htree_fill_tree+0xad/0x330
[<0>] ext4_readdir+0x6a3/0x980
[<0>] iterate_dir+0x9e/0x1a0
[<0>] ksys_getdents64+0xa0/0x130
[<0>] __x64_sys_getdents64+0x1e/0x30
[<0>] do_syscall_64+0x5e/0x110
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[<0>] 0xffffffffffffffff


Some investigations on the kernel side:
By git bisect, I found the problem is related to this commit: =
https://github.com/torvalds/linux/commit/9a9c3c02eacecf4bfde74b08ed32749a4=
929a2cf .
The kernel with this commit (9a9c3c02) can reproduce the problem, revert =
the commit and the problem disappears.


Some Logical analysis about the nbd block size changing:
1. rbd-nbd map rbdpool/foo     =20
   =3D> ioctl NBD_BLKSZSET 512=20
     =3D> nbd_size_set()=20
       =3D> nbd_size_update(nbd)=20
         =3D>{
                 bdev =3D bdget_disk(nbd->disk, 0);
                 bd_set_size(bdev, 512) =20
                 set_blocksize(bdev, 512)
              }

2. mkfs.ext4 /dev/nbd0

3. mount /dev/nbd0 /mnt   =20
   =3D> vfs mount
     =3D>  ext4_mount()=20
       =3D> =E2=80=A6=20
         =3D> sb_set_blocksize()=20
           =3D> set_blocksize(bdev, 4096)   <=3D mount ext4 will set the =
nbd blocksize to 4096

4. rbd resize =E2=80=93size 4G rbdpool/foo  =20
   =3D> ioctl NBD_SET_SIZE 4G   <=3D rbd-nbd will update the latest =
total size of nbd device
     =3D>  nbd_size_set()=20
       =3D> nbd_size_update(nbd)=20
         =3D>{
                 bdev =3D bdget_disk(nbd->disk, 0);
                 bd_set_size(bdev, 512) =20
                 set_blocksize(bdev, 512)   <=3D the blocksize is set =
back to 512 [code line: set_blocksize(bdev, config->blksize);  ]. It =
seems to be the root cause.
              }


