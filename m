Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57550345D
	for <lists+linux-block@lfdr.de>; Sat, 16 Apr 2022 07:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiDPGBV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 Apr 2022 02:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPGBV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Apr 2022 02:01:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65FA6213C
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 22:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gU0yYpKruvAcYODaycpgnNMrkQfFOoDNcDnBic7CSRQ=; b=l9oYKltFADqlqKwobKYqiDmGMf
        g+KhQc5Yebii4Djqsgkm5cTMbV+FLJjvd/wBMcGIxNuRUFckp1w7aDfn6bUdt7ZJcALPUWAOLL4zg
        kzBZdUC9tNN6hB99rBvGaZQAB/TQ5DVkD2yagRaunN1CzOQBT8smsVSUUJGmK8eV2pKwd8U2O10jw
        noItra32AkIi2UcOoS3UUGGDmZaNW5BfmJYHIIu5/7Hqp8GUxPQAnVbrhfVYdNEajLLlqKMc1osB4
        tWSPHQR1NLk4WkgmScnVRqnb99JKyoBl4jLw7B8eXCANclYGKzNoAg0F6R0k+ZvVusSsWqiWxXCBC
        kTQqRYUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfbSL-00CJdS-UQ; Sat, 16 Apr 2022 05:58:49 +0000
Date:   Fri, 15 Apr 2022 22:58:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/8] dm: io accounting & polling improvement
Message-ID: <YlpbGbtc5NwD64KH@infradead.org>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <YlWzoj+M1ykUubH+@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlWzoj+M1ykUubH+@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12, 2022 at 01:15:14PM -0400, Mike Snitzer wrote:
> I'll review this closely but, a couple weeks ago, I queued up quite a
> lot of conflicting changes for 5.19 here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.19

Can you please end them out to the device mapper list for review?
