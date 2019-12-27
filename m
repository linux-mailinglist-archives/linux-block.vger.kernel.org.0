Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6E12BBC9
	for <lists+linux-block@lfdr.de>; Sat, 28 Dec 2019 00:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfL0XGR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Dec 2019 18:06:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36233 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbfL0XGF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Dec 2019 18:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577487964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pO67oKckAEnlLHwXcxVKmWpBJh2vxyXs0ypYmFGIJ/I=;
        b=dVg5G6xxgYg8x7SEgaej8WofLfwJ6TBt60huHIAKNh81TlEh07+6/pYS8HL1C6etv3bgR/
        DgvSnbRCdWRnhEKagFu0eFB7C7ekzabmDtsCSUmbrWLFmiaUCO0/MCXZ6BP9UMYnk10DgI
        0089jkn6+B0bEjHgOg6qA7iMuoM7IF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-JHnxqUpnOKeZoT7O3pPjoQ-1; Fri, 27 Dec 2019 18:06:03 -0500
X-MC-Unique: JHnxqUpnOKeZoT7O3pPjoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A9B41005502;
        Fri, 27 Dec 2019 23:06:02 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3BE5D9C5;
        Fri, 27 Dec 2019 23:05:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
Subject: [PATCH V2] block: add bio_truncate to fix guard_bio_eod
Date:   Sat, 28 Dec 2019 07:05:48 +0800
Message-Id: <20191227230548.20079-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some filesystem, such as vfat, may send bio which crosses device boundary=
,
and the worse thing is that the IO request starting within device boundar=
ies
can contain more than one segment past EOD.

Commit dce30ca9e3b6 ("fs: fix guard_bio_eod to check for real EOD errors"=
)
tries to fix this issue by returning -EIO for this situation. However,
this way lets fs user code lose chance to handle -EIO, then sync_inodes_s=
b()
may hang for ever.

Also the current truncating on last segment is dangerous by updating the
last bvec, given bvec table becomes not immutable any more, and fs bio
users may not retrieve the truncated pages via bio_for_each_segment_all()=
 in
its .end_io callback.

Fixes this issue by supporting multi-segment truncating. And the
approach is simpler:

- just update bio size since block layer can make correct bvec with
the updated bio size. Then bvec table becomes really immutable.

- zero all truncated segments for read bio

Cc: Carlos Maiolino <cmaiolino@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Fixed-by: dce30ca9e3b6 ("fs: fix guard_bio_eod to check for real EOD erro=
rs")
Reported-by: syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- not export bio_truncate as suggested by Jens

 block/bio.c         | 39 +++++++++++++++++++++++++++++++++++++++
 fs/buffer.c         | 25 +------------------------
 include/linux/bio.h |  1 +
 3 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a5d75f6bf4c7..006bcc52a77e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -538,6 +538,45 @@ void zero_fill_bio_iter(struct bio *bio, struct bvec=
_iter start)
 }
 EXPORT_SYMBOL(zero_fill_bio_iter);
=20
+void bio_truncate(struct bio *bio, unsigned new_size)
+{
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	unsigned int done =3D 0;
+	bool truncated =3D false;
+
+	if (new_size >=3D bio->bi_iter.bi_size)
+		return;
+
+	if (bio_data_dir(bio) !=3D READ)
+		goto exit;
+
+	bio_for_each_segment(bv, bio, iter) {
+		if (done + bv.bv_len > new_size) {
+			unsigned offset;
+
+			if (!truncated)
+				offset =3D new_size - done;
+			else
+				offset =3D 0;
+			zero_user(bv.bv_page, offset, bv.bv_len - offset);
+			truncated =3D true;
+		}
+		done +=3D bv.bv_len;
+	}
+
+ exit:
+	/*
+	 * Don't touch bvec table here and make it really immutable, since
+	 * fs bio user has to retrieve all pages via bio_for_each_segment_all
+	 * in its .end_bio() callback.
+	 *
+	 * It is enough to truncate bio by updating .bi_size since we can make
+	 * correct bvec with the updated .bi_size for drivers.
+	 */
+	bio->bi_iter.bi_size =3D new_size;
+}
+
 /**
  * bio_put - release a reference to a bio
  * @bio:   bio to release reference to
diff --git a/fs/buffer.c b/fs/buffer.c
index d8c7242426bb..e94a6619464c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3034,8 +3034,6 @@ static void end_bio_bh_io_sync(struct bio *bio)
 void guard_bio_eod(int op, struct bio *bio)
 {
 	sector_t maxsector;
-	struct bio_vec *bvec =3D bio_last_bvec_all(bio);
-	unsigned truncated_bytes;
 	struct hd_struct *part;
=20
 	rcu_read_lock();
@@ -3061,28 +3059,7 @@ void guard_bio_eod(int op, struct bio *bio)
 	if (likely((bio->bi_iter.bi_size >> 9) <=3D maxsector))
 		return;
=20
-	/* Uhhuh. We've got a bio that straddles the device size! */
-	truncated_bytes =3D bio->bi_iter.bi_size - (maxsector << 9);
-
-	/*
-	 * The bio contains more than one segment which spans EOD, just return
-	 * and let IO layer turn it into an EIO
-	 */
-	if (truncated_bytes > bvec->bv_len)
-		return;
-
-	/* Truncate the bio.. */
-	bio->bi_iter.bi_size -=3D truncated_bytes;
-	bvec->bv_len -=3D truncated_bytes;
-
-	/* ..and clear the end of the buffer for reads */
-	if (op =3D=3D REQ_OP_READ) {
-		struct bio_vec bv;
-
-		mp_bvec_last_segment(bvec, &bv);
-		zero_user(bv.bv_page, bv.bv_offset + bv.bv_len,
-				truncated_bytes);
-	}
+	bio_truncate(bio, maxsector << 9);
 }
=20
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 3cdb84cdc488..853d92ceee64 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -470,6 +470,7 @@ extern struct bio *bio_copy_user_iov(struct request_q=
ueue *,
 				     gfp_t);
 extern int bio_uncopy_user(struct bio *);
 void zero_fill_bio_iter(struct bio *bio, struct bvec_iter iter);
+void bio_truncate(struct bio *bio, unsigned new_size);
=20
 static inline void zero_fill_bio(struct bio *bio)
 {
--=20
2.20.1

