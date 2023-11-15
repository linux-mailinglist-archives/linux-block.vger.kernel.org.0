Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593877DBBF2
	for <lists+linux-block@lfdr.de>; Mon, 30 Oct 2023 15:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjJ3Ok7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Oct 2023 10:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJ3Ok6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2023 10:40:58 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E2CC
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 07:40:54 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231030144051euoutp0136dd3071c63085774f4b2d0d74a80d2c~S6ZilVbNO3251232512euoutp01Z
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 14:40:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231030144051euoutp0136dd3071c63085774f4b2d0d74a80d2c~S6ZilVbNO3251232512euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698676851;
        bh=7vEqq26SzxQ6PkARHOhjcaxlR5mTDPMvCCTqwuUfuO4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=rYpN92E/MHgPHXl7lEMr8OAU7VOYfaQk9mF+jkbJY5teuAbtfTBCX4VZDR/e59Yvd
         C3x+gH1FXC5IXI6bP9BwQrMKtJlAWuod5GOZOx/Gus6F1q1Ruz40SkmegVSDWO54nn
         zbd+sHHEKLJ8R8xgPxs1GEa/8arFBz65a203SHpI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231030144050eucas1p2f37991834be6210119c18e1e48b42dc7~S6ZiOyTA-1690516905eucas1p2-;
        Mon, 30 Oct 2023 14:40:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 15.2C.42423.270CF356; Mon, 30
        Oct 2023 14:40:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231030144050eucas1p12ede963088687846d9b02a27d7da525e~S6Zhts8fs3038730387eucas1p1G;
        Mon, 30 Oct 2023 14:40:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231030144050eusmtrp133a2b43dc3a97345dfae8ef264d47ec2~S6ZhtFjPS0879508795eusmtrp14;
        Mon, 30 Oct 2023 14:40:50 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-64-653fc0723ef8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.66.25043.270CF356; Mon, 30
        Oct 2023 14:40:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231030144050eusmtip230b5bbc97899291e5b39aee6005c14c3~S6Zhg2dtJ2861528615eusmtip2W;
        Mon, 30 Oct 2023 14:40:50 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 30 Oct 2023 14:40:49 +0000
Date:   Mon, 30 Oct 2023 15:40:47 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Keith Busch <kbusch@meta.com>
CC:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <joshi.k@samsung.com>, <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, <p.raghav@samsung.com>
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <20231030144047.yrwejvdyyi4vo62m@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231027181929.2589937-2-kbusch@meta.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xSYRjexzkeDhR1RDe/LtqgWamFsazYcpWrFbWuv9y6KeiXNhGLI2V2
        w62LlkVhaqIu7SKEKw3R7OJsrLQUKcoyLzXdorKyIV1MK0o4tvr3fM/lfd9n+0iMX+I3mdyh
        TEcqpUwhJLh4XdOwfY7q7hI0t+2nWFL5UktIrlTeZ0k+HbHjEp31OZDYnpXjkoauCMn5Cidb
        Ymj2sJaS0qdtaqnZlENIay4dkt7u1BBSuyNDOujswqWfzSEb2Ju40YlIsWM3UkUujucmV5g0
        7J0GXkbh9V5CA35zjgMOCako+MVZih8HXJJPGQE0uzQE8/gCoOfWSRbz+AxgzXA/+BtxVX8d
        ixgA7Mg7gXkFn6vEpGQEC4C1BYO4V8CpUPi2oWd0FEkSVDjMymF76UBKAB91Musw77revKs+
        IYBaDbuzhvy8mEcthEcMtSwG+8OHRa99MzFqNiy77Sa8MzFqCjR4SC/NGbV/b60nmEOFUFNj
        wxl8ALZYunxtIOUiofFONZsRlkNLW/cYDoDvmy1jeCpszcsdC++Dzhc/MCZ8GEDtzSrfYkgt
        gqdsCsYTA385C1gMPQG+GPBnzpwAdXWFGEPzYPZRPuOeAStffcRPg+n6/4rp/yum/1esDGAm
        EITUdGoSosVKtEdEy1JptTJJlJCWagajH6jV0+yuB6XvB0VWwCKBFUASEwbysJhoxOclyvZm
        IlVanEqtQLQVTCFxYRAvNHEa4lNJsnSUgtBOpPqrskjOZA3rwjK6Z3MRpZm0LOa5PEzX7r9/
        VaTujm4g8iC3KfZc3zAdtrTYkrtNP49TaHMV9gq+hTzBR+Zr7e6Png1vgs5YkkPOmM8H10Td
        3Vg10dSRe+5GrdHRpFWvMJTLyz+0JIlcYE3E+ASj49ehgKyV7q2N+FCRRh68v+6geyTTUFq2
        a5Jiy559qJa/PreVHhqPBKtSdNMKHNS10ITHynsN2YtKsi/G+MVLmwRf160trSoYJ3h31tqX
        ISC2jxwDwSpxv6hdHjhvZnqOusfRuMA+PbazLGrhkC2+d1yHcT03TjfxVr58RkWOebaec3bW
        g+hgWwQ68SbTdLlRvFmbll/cHibE6WSZOBxT0bI/orIfaK8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7pFB+xTDW7c5LdYfbefzWLl6qNM
        Fu9az7FYTDp0jdHizNWFLBZ7b2lbzF/2lN1i+fF/TA4cHpfPlnpsWtXJ5rF5Sb3H7psNbB7n
        LlZ4fHx6i8Xj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU
        1JzMstQifbsEvYxlqxrYC5bzVkzf+ICtgfE/ZxcjJ4eEgInEhw1fWboYuTiEBJYySlxa9IQJ
        IiEjsfHLVVYIW1jiz7UuNoiij4wSJ5++ZoZwtjBKHN60AKyDRUBV4vneO0A2BwebgJZEYyc7
        SFhEQFHiPND9IPXMAl8YJR5MXguWEBbwkrjd+B1sA6+AuUTr8q1gvUICyRKLJhZAhAUlTs58
        wgJiMwvoSCzY/YkNpIRZQFpi+T8OkDAnUOeP0zvYIO5UkmjYfIYFwq6V+Pz3GeMERuFZSCbN
        QjJpFsKkBYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjcNuxn1t2MK589VHvECMTB+Mh
        RgkOZiURXmZHm1Qh3pTEyqrUovz4otKc1OJDjKbAgJjILCWanA9MBHkl8YZmBqaGJmaWBqaW
        ZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUw+Lmv19voq1zPOmG+s9mrdKYVakUvr5yy5
        IKD//MvUr64FORzX0q0mPz1bGdKwQMenxLZPyKhi/dWJO4prYxJN10xx5yya2i67hWu1trbq
        XY4Xn0WEROdO3xbJGOwf9Hh/xe6GwCcLcp8e5Zqtc2zabifDQs+NQiWuK/ta+lacOl/sd+xa
        9s/dPNPy073emfZnvFS0kNjInVOjauVev99/mvlxiRcHNnO+azt0xv9NdUGjkHuSll/g9W+V
        PQf9dnZxWoRG72K0mOC7PKUs46hjXEGC1Cf3Bp1/62fcmRPBdaYiPf1j9uXOa4vqdD2kvdO1
        F2dyiC7uZfbfo/zq4Nxj+pNDbq3h3fG92MT4mxJLcUaioRZzUXEiADSWan1MAwAA
X-CMS-MailID: 20231030144050eucas1p12ede963088687846d9b02a27d7da525e
X-Msg-Generator: CA
X-RootMTR: 20231030144050eucas1p12ede963088687846d9b02a27d7da525e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231030144050eucas1p12ede963088687846d9b02a27d7da525e
References: <20231027181929.2589937-1-kbusch@meta.com>
        <20231027181929.2589937-2-kbusch@meta.com>
        <CGME20231030144050eucas1p12ede963088687846d9b02a27d7da525e@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
> +				   int nr_vecs, unsigned int len,
> +				   unsigned int direction, u32 seed)
> +{
> +	struct bio_integrity_payload *bip;
> +	struct bio_vec *copy_vec = NULL;
> +	struct iov_iter iter;
> +	void *buf;
> +	int ret;
> +
> +	/* if bvec is on the stack, we need to allocate a copy for the completion */
> +	if (nr_vecs <= UIO_FASTIOV) {
> +		copy_vec = kcalloc(sizeof(*bvec), nr_vecs, GFP_KERNEL);
> +		if (!copy_vec)
> +			return -ENOMEM;
> +		memcpy(copy_vec, bvec, nr_vecs * sizeof(*bvec));
> +	}
> +
> +	buf = kmalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		goto free_copy;

ret is not set to -ENOMEM here.

> +
> +	if (direction == ITER_SOURCE) {
> +		iov_iter_bvec(&iter, direction, bvec, nr_vecs, len);
> +		if (!copy_from_iter_full(buf, len, &iter)) {
> +			ret = -EFAULT;
> +			goto free_buf;
> +		}
> +	} else {
> +		memset(buf, 0, len);
> +	}
> +
> +	/*
> +	 * We just need one vec for this bip, but we need to preserve the
> +	 * number of vecs in the user bvec for the completion handling, so use
> +	 * nr_vecs.
> +	 */
> +	bip = bio_integrity_alloc(bio, GFP_KERNEL, nr_vecs);
> +	if (IS_ERR(bip)) {
> +		ret = PTR_ERR(bip);
> +		goto free_buf;
> +	}
> +
> +	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
> +				     offset_in_page(buf));
> +	if (ret != len) {
> +		ret = -ENOMEM;
> +		goto free_bip;
> +	}
> +
> +	bip->bip_flags |= BIP_INTEGRITY_USER;
> +	bip->copy_vec = copy_vec ?: bvec;
> +	return 0;
> +free_bip:
> +	bio_integrity_free(bio);
> +free_buf:
> +	kfree(buf);
> +free_copy:
> +	kfree(copy_vec);
> +	return ret;
> +}
> +
