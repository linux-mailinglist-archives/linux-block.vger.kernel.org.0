Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFB66173F
	for <lists+linux-block@lfdr.de>; Sun,  8 Jan 2023 18:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjAHRNm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 8 Jan 2023 12:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjAHRNi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 12:13:38 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71686BC03
        for <linux-block@vger.kernel.org>; Sun,  8 Jan 2023 09:13:38 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D6DDF68AA6; Sun,  8 Jan 2023 18:13:35 +0100 (CET)
Date:   Sun, 8 Jan 2023 18:13:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 1/2] block: make BLK_DEF_MAX_SECTORS unsigned
Message-ID: <20230108171335.GA20522@lst.de>
References: <20230105205146.3610282-1-kbusch@meta.com> <20230105205146.3610282-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105205146.3610282-2-kbusch@meta.com>
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
