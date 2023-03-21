Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1026A6C2DA3
	for <lists+linux-block@lfdr.de>; Tue, 21 Mar 2023 10:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCUJJn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Mar 2023 05:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCUJJl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 05:09:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BD249C7
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 02:09:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DEDB868AFE; Tue, 21 Mar 2023 10:09:08 +0100 (CET)
Date:   Tue, 21 Mar 2023 10:09:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <20230321090908.GA27216@lst.de>
References: <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com> <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org> <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com> <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org> <ZBj99Oy5FPDI+Gdn@ovpn-8-18.pek2.redhat.com> <a9347617-70b3-3cc1-ea5e-c6bd78c29acd@opensource.wdc.com> <ZBkTwV7UC5QDtRyj@ovpn-8-18.pek2.redhat.com> <9c74df25-aa99-afc2-4f40-3201dd67368e@opensource.wdc.com> <ZBlkF7zjQyahk5gv@ovpn-8-18.pek2.redhat.com> <cbf73fed-265f-b244-608c-bfcf5c1b6d4d@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf73fed-265f-b244-608c-bfcf5c1b6d4d@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 05:51:29PM +0900, Damien Le Moal wrote:
> Interesting. We have never seen such issue in practice with the device mappers
> that support zoned devices. But it seems interesting to try to find a use case
> that could trigger this. Will look into it, and if everything is fixed, it would
> still be a good regression test for blocktest.

I think it requires a non-zoneappend bio that is large enough to
require splitting and which goes through a remapper.
