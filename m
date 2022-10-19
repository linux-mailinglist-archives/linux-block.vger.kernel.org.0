Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6F4603AA8
	for <lists+linux-block@lfdr.de>; Wed, 19 Oct 2022 09:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJSHam (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Oct 2022 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJSHaj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 03:30:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128075F204
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 00:30:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 72A9F68C4E; Wed, 19 Oct 2022 09:30:35 +0200 (CEST)
Date:   Wed, 19 Oct 2022 09:30:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: blk_mq_quiesce_queue in del_gendisk
Message-ID: <20221019073035.GB11606@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Based on the per-tagset srcu for quiesce discusion I've been wondering
why we need the queue quiesce around elevator_exit and rq_qos_exit in
del_gendisk.  At the point where we call it, we've stopped new fs
I/O submissions, and the queue is frozen.  What does the quiesce still
protect against, and if anything can we come up with a cheaper way to
do that?
