Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF861EAB0
	for <lists+linux-block@lfdr.de>; Mon,  7 Nov 2022 06:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiKGFsr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Nov 2022 00:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiKGFsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 00:48:47 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8FFB4AE;
        Sun,  6 Nov 2022 21:48:46 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 215F268BFE; Mon,  7 Nov 2022 06:48:44 +0100 (CET)
Date:   Mon, 7 Nov 2022 06:48:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 4/7] ata: libata: cleanup fua support detection
Message-ID: <20221107054843.GC28873@lst.de>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com> <20221107005021.1327692-5-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107005021.1327692-5-damien.lemoal@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
