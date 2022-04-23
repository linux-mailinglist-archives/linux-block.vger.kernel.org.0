Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E1C50CC75
	for <lists+linux-block@lfdr.de>; Sat, 23 Apr 2022 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiDWQ6b (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 23 Apr 2022 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiDWQ6a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Apr 2022 12:58:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4262180C
        for <linux-block@vger.kernel.org>; Sat, 23 Apr 2022 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c8pzfkie7KZBcsbeHOes2SAs+NZkafum8oz9xP2IPQg=; b=MH6rmQ5xUCJ13bOuqnPTADYF2B
        G1quwiUdf0BbjSTVFFg/S4kctGD8BIKc/K/VEm4M+Tmzv71HIZusEsEitcG90Ad5gq5jtHouVxBic
        AG0CFma7Yvc4nN5rEX5ogtmnR3i1ZgqQ5jQfUlLResxq3ufGcQWtDj0Op7MEWHItEPl/5XEOdLeTU
        7XgJLH/QJlbtDNW/a0ZtsC98131WWovHPgZ6mypAoP7MbCE+q7gnFEIC8Cg1WyRS7sx8wRYLyT4Pm
        SHQ9kKzsqcxDnwveSycCK6U6q6/GjUaCkrokjmiLJrFRvyId2UtDpCBbJ8WstlCzgOJaVrrP585dL
        Akz352fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niJ2f-004gEs-Hx; Sat, 23 Apr 2022 16:55:29 +0000
Date:   Sat, 23 Apr 2022 09:55:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, tj@kernel.org,
        axboe@kernel.dk, dm-devel@redhat.com
Subject: Re: [PATCH] block: remove redundant blk-cgroup init from __bio_clone
Message-ID: <YmQvgdqHlsQVpxR+@infradead.org>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
 <YkVBjUy9GeSMbh5Q@fedora>
 <YkVxLN9p0t6DI5ie@infradead.org>
 <YlBX+ytxxeSj2neQ@redhat.com>
 <YlEWfc39+H+esrQm@infradead.org>
 <YlReKjjWhvTZjfg/@redhat.com>
 <YlRiUVFK+a0DwQhu@redhat.com>
 <YlRmhlL8TtQow0W0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlRmhlL8TtQow0W0@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So while I'm still diving into the somewhat invasive changes to
optimize some of the cloning all we might relaly need for your
use case should be this:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-clone-no-bdev

Can you check if this helps you?

