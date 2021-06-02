Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC57399347
	for <lists+linux-block@lfdr.de>; Wed,  2 Jun 2021 21:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFBTMU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Jun 2021 15:12:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37832 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFBTMR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 15:12:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1loWG8-0008Vg-1e; Wed, 02 Jun 2021 19:10:32 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        linux-block@vger.kernel.org
From:   Colin Ian King <colin.king@canonical.com>
Subject: regression: block: take bd_mutex around delete_partitions in
 del_gendisk
Message-ID: <ebbf1403-f532-ee78-9f21-41f3adfb1bbc@canonical.com>
Date:   Wed, 2 Jun 2021 20:10:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I've hit a regression in the 5.13-rc4 kernel with loop mounting. When
running the stress-ng loop stress test with multiple CPUs (e.g. 8) with
multiple stressors I get softlock hangs with the following commit:

commit c76f48eb5c084b1e15c931ae8cc1826cd771d70d (refs/bisect/bad)
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 6 08:22:56 2021 +0200

    block: take bd_mutex around delete_partitions in del_gendisk

How to reproduce (run on a multi-threaded machine):

git clone git://kernel.ubuntu.com/cking/stress-ng
cd stress-ng
make clean
make
sudo ./stress-ng --loop 8 -t 60 -v

Without the commit the stress test will complete. With the commit the
stressors will softlock up after a couple of minutes or so.

The stress-ng stressor does force some races as it does rapid loopback
exercising.

Colin
