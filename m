Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C9F5BDEA2
	for <lists+linux-block@lfdr.de>; Tue, 20 Sep 2022 09:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiITHos (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Sep 2022 03:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiITHoS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 03:44:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1147363F05
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FgWee/C/pq4t6/OTBlSC04Qm1774Pt4T1at2a5x1VUM=; b=w8VB7CGywmYran1HTQZ85zEtRS
        2mLQuaYdeOca46Nhcnp/RNpHxcoo8ZX/JiIJjejKYxBxw5K219evbHCNr/rl6h6g+CHeVMMJy2fbp
        PbrYaulZdZVP8/diEpvEYkdIGAbMeg4O2R6+ESl97sXpYP93I5jhq79bcHJXGjtnrydnOj8UUqC5f
        So3xISOhyBKakJtefL8MVgAfXOBgnqsRSh6moHiXYFDBSjUaMIkPnmBehvtYfsHDpRNew82lZBm1g
        x5ooGXaXxtEpzvYAnbwSmtZZ3jJgK4PCw3yci9RqEb3KsWroQDFY8eTdppdOGYx2a+5cTd1+eTn7h
        ezrlD9Ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXuM-001SAe-B0; Tue, 20 Sep 2022 07:43:06 +0000
Date:   Tue, 20 Sep 2022 00:43:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>, linux-block@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH 0/3] virtio-blk: support zoned block devices
Message-ID: <YylvChyEpFUiAuu8@infradead.org>
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 18, 2022 at 10:29:18PM -0400, Dmitry Fomichev wrote:
> In its current form, the virtio protocol for block devices (virtio-blk)
> is not aware of zoned block devices (ZBDs) but it allows the driver to
> successfully scan a host-managed drive provided by the virtio block
> device. As the result, the host-managed drive is recognized by the
> virtio driver as a regular, non-zoned drive that will operate
> erroneously under the most common write workloads. Host-aware ZBDs are
> currently usable, but their performance may not be optimal because the
> driver can only see them as non-zoned block devices.

What is the advantage in extending virtio-blk vs just using virtio-scsi
or nvme with shadow doorbells that just work?

